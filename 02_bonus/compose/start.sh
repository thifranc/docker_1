#! /bin/bash

#those are the defaults values
site=('monsieur')
device=('desktop')
mode="dev"
build=""

#those are the reference arrays
#for your arguments
devices=('desktop' 'mobile')
apis=('public' 'private')
modes=('dev' 'prod')
sites=('mr' 'monsieur' 'mme' 'madame' 'bb' 'bebe' 'toolbox' 'all')

#default services started : public should not be in args otherwise it will overwrite all services
services="public-api database nginx redis rabbitmq "

PWD=$(pwd)

#the "help" argument will display the usage
if [[ $# == 1 && $1 == 'help' ]]
    then
    echo -e "defaults values : site=$site device=$device mode=$mode build_option=null
    possibles arguments :
        devices= [${devices[@]}]
        apis= [${apis[@]}]
        modes= [${modes[@]} both]
        sites= [${sites[@]}]
    ./start [-b or --build][modes][devices][sites] and I add $services
    start only one API : ./start [public or private]
    "
    exit 1
fi

#the "stop" argument stop all running containers but a ctrl-C should be enough
if [[ $# == 1 && $1 == 'stop' ]]
    then
    docker stop $(docker ps -qf "status=running" --format '{{.Names}}')
    exit 1
fi

#set environnement variables used by docker_compose
if [ -z "$DB_BLACK_PEARL_POSTGRES" ]
then
	DB_BLACK_PEARL_POSTGRES="$PWD/database/data"
	export DB_BLACK_PEARL_POSTGRES=$DB_BLACK_PEARL_POSTGRES
	echo "setting DB_BLACK_PEARL_POSTGRES to $DB_BLACK_PEARL_POSTGRES THIS MESSAGE SHOULD NOT APPEAR UPDATE YOUR ENV"
fi

if [ -z "$DB_BLACK_PEARL_REDIS" ]
then
    DB_BLACK_PEARL_REDIS="$PWD/redis/data"
    export DB_BLACK_PEARL_REDIS=$DB_BLACK_PEARL_REDIS
	echo "setting DB_BLACK_PEARL_POSTGRES to $DB_BLACK_PEARL_REDIS THIS MESSAGE SHOULD NOT APPEAR UPDATE YOUR ENV"
fi

containsElement () {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}

#iterate through all arguments and overload default values if necessary
#in order to start the services required by your command
clearedSite="false"
for var in "$@"
do
	if containsElement "$var" "${sites[@]}"
	then
        #append all mr mme bb in command in an array named site
        #if any site is to be launched, clear the default site (= monsieur)
        if [[ $clearedSite == "false" ]]
        then
            site=()
            clearedSite="true"
        fi
        if [[ $var == ${sites[0]} || $var == ${sites[1]} ]]
        then
            site+=(${sites[1]})
        elif [[ $var == ${sites[2]} || $var == ${sites[3]} ]]
        then
            site+=(${sites[3]})
        elif [[ $var == ${sites[4]} || $var == ${sites[5]} ]]
        then
            site+=(${sites[5]})
        elif [[ $var == ${sites[6]} ]]
        then
        #site == toolbox
            site+=(${sites[6]})
        elif [[ $var == ${sites[7]} ]]
        #site == all
        then
            site=(${sites[1]} ${sites[3]} ${sites[5]} ${sites[6]})
        fi
    elif [[ $var == "-b" || $var == "--build" ]]
    then
        #load build option
        build="--build"
    elif containsElement "$var" "${modes[@]}"
    then
        #load mode option (will include hot reloading confFiles or not)
        mode=$var
    elif containsElement "$var" "${devices[@]}"
    then
        #load device relatively to devices
        device=($var)
    elif [[ $var == "both" ]]
    then
        device=("${devices[@]}")
    elif containsElement "$var" "${apis[@]}"
    then
        #possible to start only the API so empty default values
        services="${var}-api database redis nginx"
        site=()
        device=()
    fi
done

echo "mode => $mode || device => ${device[@]} || site => ${site[@]} || build => $build"

#generate all confFiles
conf=()
for dev in "${device[@]}"
do
    for sit in "${site[@]}"
    do
        if [[ $sit == "${sites[6]}" ]]
        then
            continue
        fi
        conf+=("${sit}/${sit}_${dev}.conf")
        if [[ $mode == "dev" ]]
        then
            conf+=("${sit}/hot_${sit}_${dev}.conf")
        fi
    done
done

#clear nginx conf files directory
rm ./nginx/nginxConf/*

#if toolbox is in args, copy all conf files
if containsElement "${sites[6]}" "${site[@]}"
then
    cp ./nginx/toolbox/* ./nginx/nginxConf/
fi

#pass private-api confFile only if toolbox or private api is to be started
if $(containsElement "${apis[1]}" "$@")
then
    cp ./nginx/api/private-api.conf ./nginx/nginxConf/
fi
if $(containsElement "${sites[6]}" "${site[@]}")
then
    cp ./nginx/api/private-api.conf ./nginx/nginxConf/
fi

#mv all confFiles to volume shared by nginx
cp ./nginx/api/public-api.conf ./nginx/nginxConf/
cp ./nginx/cdn/cdn.conf ./nginx/nginxConf/
for fileConf in "${conf[@]}"
do
    cp ./nginx/${fileConf} ./nginx/nginxConf/
done

#generate all services to run
#(as reminder, api nginx and database are mandatory
#to run either of bebe madame monsieur services)
for dev in "${device[@]}"
do
    for sit in "${site[@]}"
    do
	#if toolbox is in args, replace public-api by private-api
        if [[ $sit == "${sites[6]}" ]]
        then
	        services+="${sit} "
	        services=`echo "$services" | sed -e s/public/private/`
	    else
	        services+="${sit}_${dev} "
        fi
    done
done

echo "starting $services"

#if mode = dev -> good
#else docker compose file option -> dev.yml
if  [[ $mode == "dev" ]]
    then
	echo "use docker.compose.yml"
        ./docker-compose up $build $services
elif [[ $mode == "prod" ]]
    then
	echo "use dev.docker.yml"
        ./docker-compose --file "./dev.docker.yml" up $build $services
fi
