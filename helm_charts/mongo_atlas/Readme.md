# Application + DB (Mongo DB Atlas)

## Instruction

#### Start the Infrustructure
1. Create `terraform.tfvars` file inside the `terraform` folder. E.x:
    ```
    public_key = <public_key>
    private_key = <public_key>

    org_id = <organization_id>

    project_name = <project_name>

    cluster_name = <cluster_name>

    cloud_provider = <AWS/GCP/...>

    region = <cloud_region>

    mongodbversion = <mongo_version>

    dbuser = <db_user>

    dbuser_password = <db_password>

    database_name = <database_name>

    ip_address = <your_ip_whitelist>
    ```
#### Init and Apply Infrastructure
- `terraform init`
- `terraform apply --auto-approve`

#### Paste from terrform output connection string to MongoDB
- `connection_string:***`
To `values.yaml` -> line 58
#### Start the Application
    `helm install application ./application`

#### Create DB inside the MongoDB `/mernproject` and change the password for root user as in Secret

## Additional Features
#### Export DB from existing MongoDB (deployment/statefulset)
1. Port-froward:
    `kubectl port-forward database-0 28018:27017`
2. Dump DB:
    `mongodump --username root --port=28018 -p <password>`

#### Import DB to MongoDB Atlas
    `mongoimport --host <host_name>:<db_port> --db <db_name> --type json --file <*.json_file> --authenticationDatabase <auth_db> --ssl --username <username> --password <password>`
