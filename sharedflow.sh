#!/bin/bash

# Set variables
COMMAND="$1"
TOKEN="$(gcloud auth print-access-token)"
requestFile=$(ls -1 | grep -v ".zip" | grep Request)
responseFile=$(ls -1 | grep -v ".zip" | grep Response)
ServiceAccount="$(Service_Account)"

# Function to display usage instructions
show_help() {
    echo ""
    echo "Manage Apigee Shared Flows in an Org"
    echo ""
    echo "Usage: $0 [command] [arguments]"
    echo ""
    echo "Commands:"
    echo "  create            -  Create a shared flow"
    echo "  deploy            -  Deploy a shared flow"
    echo "  undeploy          -  Undeploy a shared flow"
    echo ""
    echo "Arguments:"
    echo "  <organization>    -  Apigee Organization Name"
    echo "  <environment>     -  Apigee Environment Name"
    echo "  <revision>        -  Sharedflow Revision"
    echo ""
    echo ""
    echo "Usage Examples:" 
    echo "  $0 create <organization>"
    echo "  $0 deploy <organization> <environment> <revision>"
    echo "  $0 undeploy <organization> <environment> <revision>"
}


# Function to chose of the shared flow
chose_shared_flow() {
    echo ""
    echo "Chose which shared flow to create, deploy & undeploy"
    echo ""
    echo ">> Select 1 or 2"
    echo ""
    echo "1) Request Shared Flow"
    echo "2) Response Shared Flow"
    echo ""
    read -p "Enter 1 or 2: " choice
}

# Function to create zip of the shared flow
zip_shared_flow() {
    # cd sharedflows
    echo ""
    echo "Request shared flow: $requestFile"
    echo ""
    echo "Response shared flow: $responseFile"
    echo ""
    if [ "$choice" = "1" ]; then
        cd $requestFile
        zip -r $requestFile.zip sharedflowbundle
    elif [ "$choice" = "2" ]; then
        cd $responseFile
        zip -r $responseFile.zip sharedflowbundle
    else
        echo "Invalid choice!"
        exit 1
    fi
}

# Function to create a shared flow
create_shared_flow() {
    ORGANIZATION="$1"
    SHARED_FLOW_NAME="$2"
    SHARED_FLOW_PATH="$3"
    echo ""
    echo "ORG: $ORGANIZATION NAME: $SHARED_FLOW_NAME  PATH: $SHARED_FLOW_PATH"
    echo "" 
    if [ "$choice" = "1" ]; then
        apigeecli sharedflows create -o "$ORGANIZATION" -n "$SHARED_FLOW_NAME" -p "$SHARED_FLOW_PATH" -t "$TOKEN"
    elif [ "$choice" = "2" ]; then
        apigeecli sharedflows create -o "$ORGANIZATION" -n "$SHARED_FLOW_NAME" -p "$SHARED_FLOW_PATH" -t "$TOKEN"
    else
        echo "Invalid choice!"
        exit 1
    fi

}

# Function to deploy a shared flow
deploy_shared_flow() {
    ORGANIZATION="$1"
    ENVIRONMENT="$2"
    REVISION="$3"
    SHARED_FLOW_NAME="$4"
    echo ""
    echo "ORG: $ORGANIZATION ENV: $ENVIRONMENT NAME: $SHARED_FLOW_NAME  REV: $REVISION"
    echo ""
    if [ "$choice" = "1" ]; then
        apigeecli sharedflows deploy -o "$ORGANIZATION" -e "$ENVIRONMENT" -n "$SHARED_FLOW_NAME" -v "$REVISION" -t "$TOKEN" -s "$ServiceAccount"
    elif [ "$choice" = "2" ]; then
        apigeecli sharedflows deploy -o "$ORGANIZATION" -e "$ENVIRONMENT" -n "$SHARED_FLOW_NAME" -v "$REVISION" -t "$TOKEN" -s "$ServiceAccount" 
    else
        echo "Invalid choice!"
        exit 1
    fi
}

# Function to undeploy a shared flow
undeploy_shared_flow() {
    ORGANIZATION="$1"
    ENVIRONMENT="$2"
    REVISION="$3"
    SHARED_FLOW_NAME="$4"
    echo ""
    echo "ORG: $ORGANIZATION ENV: $ENVIRONMENT NAME: $SHARED_FLOW_NAME  REV: $REVISION"
    echo ""
    if [ "$choice" = "1" ]; then
        apigeecli sharedflows undeploy -o "$ORGANIZATION" -e "$ENVIRONMENT" -n "$SHARED_FLOW_NAME" -v "$REVISION" -t "$TOKEN"
    elif [ "$choice" = "2" ]; then
        apigeecli sharedflows undeploy -o "$ORGANIZATION" -e "$ENVIRONMENT" -n "$SHARED_FLOW_NAME" -v "$REVISION" -t "$TOKEN"
    else
        echo "Invalid choice!"
        exit 1
    fi
}


# Determine which command to run based on the provided argument
case "$COMMAND" in
    create)
        if [ "$#" -ne 2 ]; then
            echo ""
            echo "Create a shared flow."
            echo ""
            echo "Usage: $0 create <organization>"
            echo ""
            echo "Use --help for usage instructions."
            exit 1
        fi

        chose_shared_flow
        zip_shared_flow

        if [ "$choice" = "1" ]; then
            create_shared_flow "$2" "$requestFile" "$requestFile.zip"
        elif [ "$choice" = "2" ]; then
            create_shared_flow "$2" "$responseFile" "$responseFile.zip"
        else
            echo "Invalid choice!"
            exit 1
        fi
        ;;
    deploy)
        if [ "$#" -ne 4 ]; then
            echo ""
            echo "Deploy a shared flow."
            echo ""
            echo "Usage: $0 deploy <organization> <environment> <revision>"
            echo ""
            echo "Use --help for usage instructions."
            exit 1
        fi

        chose_shared_flow

        if [ "$choice" = "1" ]; then
            deploy_shared_flow "$2" "$3" "$4" "$requestFile"
        elif [ "$choice" = "2" ]; then
            deploy_shared_flow "$2" "$3" "$4" "$responseFile"
        else
            echo "Invalid choice!"
            exit 1
        fi
        ;;
    undeploy)
        if [ "$#" -ne 4 ]; then
            echo ""
            echo "Undeploy a shared flow."
            echo ""
            echo "Usage: $0 undeploy <organization> <environment> <revision>"
            echo ""
            echo "Use --help for usage instructions."
            exit 1
        fi

        chose_shared_flow

        if [ "$choice" = "1" ]; then
            undeploy_shared_flow "$2" "$3" "$4" "$requestFile"
        elif [ "$choice" = "2" ]; then
            undeploy_shared_flow "$2" "$3" "$4" "$responseFile"
        else
            echo "Invalid choice!"
            exit 1
        fi
        ;;
    --help)
        show_help
        exit 0
        ;;
    *)
        echo "Invalid command. Use --help for usage instructions."
        exit 1
        ;;
esac

