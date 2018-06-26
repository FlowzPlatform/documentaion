# Travis CI is a hosted, distributed continuous integration service for open source & private projects.

### Purpose:
```
First we have to build docker image of the code. Then push that image in to docker hub. After that upgrade those image in rancher.
```
![selection_048](https://user-images.githubusercontent.com/28925482/41890979-c61d74b0-792f-11e8-8ba2-3b72be884297.png)

## (1) Make .travis.yml file in Root directory of project.

write image_name(ex. crmadmin_frontend_flowz) according to your project. And pass environment variables through travis. 

```
sudo: required

language: node

services:
  - docker

branches:
  only:
  - master
  - develop
  - staging
  - QA

jobs:
  include:
    - stage: Crmadmin-Frontend-Flowz
      script:
      - 'if [ ${TRAVIS_BRANCH} = "master" ]; then
            docker login -u="$DOCKER_USERNAME_FLOWZ" -p="$DOCKER_PASSWORD_FLOWZ";
            docker build -t crmadmin_frontend_flowz:latest --build-arg domainkey="$DOMAINKEY_MASTER" .;
            docker images;
            docker tag crmadmin_frontend_flowz:latest $DOCKER_USERNAME_FLOWZ/crmadmin_frontend_flowz:latest;
            docker push $DOCKER_USERNAME_FLOWZ/crmadmin_frontend_flowz:latest;
        elif [ ${TRAVIS_BRANCH} = "develop" ]; then
            docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD";
            docker build -t crmadmin_frontend_flowz:dev --build-arg domainkey="$DOMAINKEY_DEVELOP" .;
            docker images;
            docker tag crmadmin_frontend_flowz:dev $DOCKER_USERNAME/crmadmin_frontend_flowz:dev;
            docker push $DOCKER_USERNAME/crmadmin_frontend_flowz:dev;
        elif [ ${TRAVIS_BRANCH} = "staging" ]; then
            docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD";
            docker build -t crmadmin_frontend_flowz:$TRAVIS_BRANCH-$TRAVIS_BUILD_NUMBER --build-arg domainkey="$DOMAINKEY_STAGING" .;
            docker tag crmadmin_frontend_flowz:$TRAVIS_BRANCH-$TRAVIS_BUILD_NUMBER $DOCKER_USERNAME/crmadmin_frontend_flowz:$TRAVIS_BRANCH-$TRAVIS_BUILD_NUMBER;
            docker tag crmadmin_frontend_flowz:$TRAVIS_BRANCH-$TRAVIS_BUILD_NUMBER $DOCKER_USERNAME/crmadmin_frontend_flowz:staging;
            docker images;
            docker push $DOCKER_USERNAME/crmadmin_frontend_flowz:$TRAVIS_BRANCH-$TRAVIS_BUILD_NUMBER;
            docker push $DOCKER_USERNAME/crmadmin_frontend_flowz:staging;
        else
            docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD";
            docker build -t crmadmin_frontend_flowz:qa --build-arg domainkey="$DOMAINKEY_QA" .;
            docker images;
            docker tag crmadmin_frontend_flowz:qa $DOCKER_USERNAME/crmadmin_frontend_flowz:qa;
            docker push $DOCKER_USERNAME/crmadmin_frontend_flowz:qa;
        fi'
    - stage: Upgrade Rancher Service
      script:
      - bash ./upgrade.sh
    - stage: Finish Rancher Service
      script:
      - bash ./finish.sh

notifications:
  email:
    recipients:
      - arpitap@officebeacon.com
      - kaushalm@officebrain.com
      - anuj@officebrain.com
      - naveeng@officebrain.com
    on_success: always
    on_failure: always
```
## (2) Add upgrade.sh file in Root directory for upgrading rancher service.

store different branch values in one variable and then use it in upgrade command.

```
if [ "$TRAVIS_BRANCH" = "master" ]
then
    {
    echo "call $TRAVIS_BRANCH branch"
    ENV_ID=`curl -u ""$RANCHER_ACCESSKEY_MASTER":"$RANCHER_SECRETKEY_MASTER"" -X GET -H 'Accept: application/json' -H 'Content-Type: application/json' "$RANCHER_URL_MASTER/v2-beta/projects?name=Production" | jq '.data[].id' | tr -d '"'`
    echo $ENV_ID
    USERNAME="$DOCKER_USERNAME_FLOWZ";
    TAG="latest";
    FRONT_HOST="$FRONT_HOST_MASTER";
    RANCHER_ACCESSKEY="$RANCHER_ACCESSKEY_MASTER";
    RANCHER_SECRETKEY="$RANCHER_SECRETKEY_MASTER";
    RANCHER_URL="$RANCHER_URL_MASTER";
  }
elif [ "$TRAVIS_BRANCH" = "develop" ]
then
    {
      echo "call $TRAVIS_BRANCH branch"
      ENV_ID=`curl -u ""$RANCHER_ACCESSKEY_DEVELOP":"$RANCHER_SECRETKEY_DEVELOP"" -X GET -H 'Accept: application/json' -H 'Content-Type: application/json' "$RANCHER_URL_DEVELOP/v2-beta/projects?name=Develop" | jq '.data[].id' | tr -d '"'`
      echo $ENV_ID
      USERNAME="$DOCKER_USERNAME";
      TAG="dev";
      FRONT_HOST="$FRONT_HOST_DEVELOP";
      RANCHER_ACCESSKEY="$RANCHER_ACCESSKEY_DEVELOP";
      RANCHER_SECRETKEY="$RANCHER_SECRETKEY_DEVELOP";
      RANCHER_URL="$RANCHER_URL_DEVELOP";
  }
elif [ "$TRAVIS_BRANCH" = "staging" ]
then
    {
      echo "call $TRAVIS_BRANCH branch"
      ENV_ID=`curl -u ""$RANCHER_ACCESSKEY_STAGING":"$RANCHER_SECRETKEY_STAGING"" -X GET -H 'Accept: application/json' -H 'Content-Type: application/json' "$RANCHER_URL_STAGING/v2-beta/projects?name=Staging" | jq '.data[].id' | tr -d '"'`
      echo $ENV_ID
      USERNAME="$DOCKER_USERNAME";
      TAG="staging";
      FRONT_HOST="$FRONT_HOST_STAGING";
      RANCHER_ACCESSKEY="$RANCHER_ACCESSKEY_STAGING";
      RANCHER_SECRETKEY="$RANCHER_SECRETKEY_STAGING";
      RANCHER_URL="$RANCHER_URL_STAGING";
  }  
else
  {
      echo "call $TRAVIS_BRANCH branch"
      ENV_ID=`curl -u ""$RANCHER_ACCESSKEY_QA":"$RANCHER_SECRETKEY_QA"" -X GET -H 'Accept: application/json' -H 'Content-Type: application/json' "$RANCHER_URL_QA/v2-beta/projects?name=QA" | jq '.data[].id' | tr -d '"'`
      echo $ENV_ID
      USERNAME="$DOCKER_USERNAME";
      TAG="qa";
      FRONT_HOST="$FRONT_HOST_QA";
      RANCHER_ACCESSKEY="$RANCHER_ACCESSKEY_QA";
      RANCHER_SECRETKEY="$RANCHER_SECRETKEY_QA";
      RANCHER_URL="$RANCHER_URL_QA";
  }
fi

SERVICE_ID=`curl -u ""$RANCHER_ACCESSKEY":"$RANCHER_SECRETKEY"" -X GET -H 'Accept: application/json' -H 'Content-Type: application/json' "$RANCHER_URL/v2-beta/projects/$ENV_ID/services?name=crmadmin-frontend-flowz" | jq '.data[].id' | tr -d '"'`
echo $SERVICE_ID

curl -u ""$RANCHER_ACCESSKEY":"$RANCHER_SECRETKEY"" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{
     "inServiceStrategy":{
		    "launchConfig": {
				  "imageUuid":"docker:'$USERNAME'/crmadmin_frontend_flowz:'$TAG'",
				 	"kind": "container",
					"labels":{
						   "io.rancher.container.pull_image": "always",
							 "io.rancher.scheduler.affinity:host_label": "'"$FRONT_HOST"'",
							 "io.rancher.scheduler.affinity:container_label_soft_ne": "io.rancher.stack_service.name=front-flowz/crmadmin-frontend-flowz"
						 },
					"healthCheck": {
					    "type": "instanceHealthCheck",
							"healthyThreshold": 2,
							"initializingTimeout": 60000,
							"interval": 2000,
							"name": null,
							"port": 80,
							"recreateOnQuorumStrategyConfig": {
											         "type": "recreateOnQuorumStrategyConfig",
															 "quorum": 1
														},
							"reinitializingTimeout": 60000,
							"requestLine": "GET \"http://localhost\" \"HTTP/1.0\"",
							"responseTimeout": 60000,
							"strategy": "recreateOnQuorum",
							"unhealthyThreshold": 3
						},
					"networkMode": "managed"
				}
			},
			"toServiceStrategy":null
		}' \
$RANCHER_URL/v2-beta/projects/$ENV_ID/services/$SERVICE_ID?action=upgrade

```

## (3) Add finish.sh file in Root directory for replacing old image with new image in rancher.

```
if [ "$TRAVIS_BRANCH" = "master" ]
then
    {
    echo "call $TRAVIS_BRANCH branch"
    ENV_ID=`curl -u ""$RANCHER_ACCESSKEY_MASTER":"$RANCHER_SECRETKEY_MASTER"" -X GET -H 'Accept: application/json' -H 'Content-Type: application/json' "$RANCHER_URL_MASTER/v2-beta/projects?name=Production" | jq '.data[].id' | tr -d '"'`
    echo $ENV_ID
    RANCHER_ACCESSKEY="$RANCHER_ACCESSKEY_MASTER";
    RANCHER_SECRETKEY="$RANCHER_SECRETKEY_MASTER";
    RANCHER_URL="$RANCHER_URL_MASTER";
  }
elif [ "$TRAVIS_BRANCH" = "develop" ]
then
    {
      echo "call $TRAVIS_BRANCH branch"
      ENV_ID=`curl -u ""$RANCHER_ACCESSKEY_DEVELOP":"$RANCHER_SECRETKEY_DEVELOP"" -X GET -H 'Accept: application/json' -H 'Content-Type: application/json' "$RANCHER_URL_DEVELOP/v2-beta/projects?name=Develop" | jq '.data[].id' | tr -d '"'`
      echo $ENV_ID
      RANCHER_ACCESSKEY="$RANCHER_ACCESSKEY_DEVELOP";
      RANCHER_SECRETKEY="$RANCHER_SECRETKEY_DEVELOP";
      RANCHER_URL="$RANCHER_URL_DEVELOP";
  }
elif [ "$TRAVIS_BRANCH" = "staging" ]
then
    {
      echo "call $TRAVIS_BRANCH branch"
      ENV_ID=`curl -u ""$RANCHER_ACCESSKEY_STAGING":"$RANCHER_SECRETKEY_STAGING"" -X GET -H 'Accept: application/json' -H 'Content-Type: application/json' "$RANCHER_URL_STAGING/v2-beta/projects?name=Staging" | jq '.data[].id' | tr -d '"'`
      echo $ENV_ID
      RANCHER_ACCESSKEY="$RANCHER_ACCESSKEY_STAGING";
      RANCHER_SECRETKEY="$RANCHER_SECRETKEY_STAGING";
      RANCHER_URL="$RANCHER_URL_STAGING";
  }  
else
  {
      echo "call $TRAVIS_BRANCH branch"
      ENV_ID=`curl -u ""$RANCHER_ACCESSKEY_QA":"$RANCHER_SECRETKEY_QA"" -X GET -H 'Accept: application/json' -H 'Content-Type: application/json' "$RANCHER_URL_QA/v2-beta/projects?name=QA" | jq '.data[].id' | tr -d '"'`
      echo $ENV_ID
      RANCHER_ACCESSKEY="$RANCHER_ACCESSKEY_QA";
      RANCHER_SECRETKEY="$RANCHER_SECRETKEY_QA";
      RANCHER_URL="$RANCHER_URL_QA";
  }
fi

SERVICE_ID=`curl -u ""$RANCHER_ACCESSKEY":"$RANCHER_SECRETKEY"" -X GET -H 'Accept: application/json' -H 'Content-Type: application/json' "$RANCHER_URL/v2-beta/projects/$ENV_ID/services?name=crmadmin-frontend-flowz" | jq '.data[].id' | tr -d '"'`
echo $SERVICE_ID

echo "waiting for service to upgrade "
    while true; do

      case `curl -u ""$RANCHER_ACCESSKEY":"$RANCHER_SECRETKEY"" \
          -X GET \
          -H 'Accept: application/json' \
          -H 'Content-Type: application/json' \
          "$RANCHER_URL/v2-beta/projects/$ENV_ID/services/$SERVICE_ID/" | jq '.state'` in
          "\"upgraded\"" )
              echo "completing service upgrade"
              curl -u ""$RANCHER_ACCESSKEY":"$RANCHER_SECRETKEY"" \
                -X POST \
                -H 'Accept: application/json' \
                -H 'Content-Type: application/json' \
                "$RANCHER_URL/v2-beta/projects/$ENV_ID/services/$SERVICE_ID?action=finishupgrade"
              break ;;
          "\"upgrading\"" )
              echo "still upgrading"
              echo -n "."
              sleep 60
              continue ;;
          *)
              die "unexpected upgrade state" ;;
      esac
    done
```

## (4) Pass environment variables through travis.

![selection_047](https://user-images.githubusercontent.com/28925482/41890266-68e13c26-792c-11e8-81eb-3ac6e5a119cb.png)

## (5) Enable the repository you want to build.

![selection_046](https://user-images.githubusercontent.com/28925482/41890059-67e85418-792b-11e8-8411-3559efaec188.png)
