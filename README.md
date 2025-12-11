# Baby Tools Shop

## Table of Contents

1. [Project Overview](#project-overview)
2. [Quickstart](#quickstart)
3. [Usage](#usage)
4. [Configuration](#configuration)
5. [Deploying with Docker](#deploying-with-docker)
6. [Hints](#hints)

## Project Overview

The **Baby Tools Shop** is a Django-based web application that allows users to browse and manage baby products.  
The project is containerized with Docker and can be run locally on a developer machine or on a virtual server (VM) using the same Docker image.

### Technologies

The application uses the following technologies:

- **Python 3.11** as the programming language.  
- **Django 5.1.2** for the web framework.  
- **Docker** for containerization and deployment.  
- **venv** for managing the local virtual environment.

## Quickstart

This section explains how to run the project **locally without Docker** for development.

1. **Clone the repository**

    ```bash
   git clone <repository_url>
   cd <repository_name>
   ```

2. **Create and activate a virtual environment**

   ```bash
   python -m venv venv
   ```

   
3. **Activate the virtual environment**

   - On Linux/macOS:

     ```bash
     source venv/bin/activate
     ```

   - On Windows (PowerShell):

     ```bash
     venv\Scripts\Activate.ps1
     ```

4. **Install dependencies**

     ```bash
     pip install -r requirements.txt
     ```


5. **Navigate to the Django project**

     ```bash
     cd babyshop_app
     ```
    

6. **Apply migrations**

     ```bash
     python manage.py makemigrations
     python manage.py migrate
     ```


7. **Create a superuser**
   
     ```bash
     python manage.py createsuperuser
     ```

Follow the prompts to set username, email and password.

8. **Run the development server**

    ```bash
     python manage.py runserver 0.0.0.0:8025
    ```

- Application:  ``` http://localhost:8025```
- Admin panel:  ``` http://localhost:8025/admin```

## Usage

### Step 1: Clone repository
Change to the desired directory on the server and clone your Git repository:
```bash
git clone <REPOSITORY_URL>
cd baby-tools-shop
```


### Step 2: Open the settings.py in babyshop_app and add this to allowed host:
``` python
import os

ALLOWED_HOSTS = [
    os.getenv("SERVER_IP", "localhost"),
]
```


### Step 3: This command creates a `.env` file and writes the `SERVER_IP` environment variable with the value `<SECRET_IP_ADRESS`. This file is used to store configuration values securely outside the source code.
``` bash
echo "SERVER_IP=<SECRET_IP_ADRESS>" > .env
```



### Step 4: Create and run a Docker image 
Creates a Docker image with the tag `baby-tools-shop` based on the Dockerfile in the current directory (.)
- docker build: The command to create (build) a Docker image.
- -t baby-tools-shop: Specifies the name (baby-tools-shop) and optionally a tag (version number) for the image. The -t stands for “tag”.
- . (dot): Specifies the current directory as the context for the build process. Docker searches this directory for a file called Dockerfile, which contains instructions for creating the image.
``` bash
docker build -t baby-tools-shop .
```



### Step 5: Start Docker container 
The command `docker run -d --env-file .env -p 8025:8025 --restart=always baby-tools-shop` is used to start a Docker container. Here's a breakdown of each part:
- `docker run`: Starts a new container based on a Docker image.
- `-d`: Runs the container in detached mode (in the background), so your terminal stays free.
- `--env-file .env`: Loads environment variables from the `.env` file into the container.
- `-p 8025:8025`: Maps port 8025 on your machine to port 8025 inside the container, making the service available at `http://localhost:8025`.
- `--restart=always`: Ensures that the container automatically restarts in the following cases:
  - If the container crashes, it is restarted immediately.
  - If the Docker service restarts, the container is started again.
  - If the server/machine reboots, the container starts automatically with the system.
  - **Exception:** If the container is manually stopped using `docker stop <container-id>`, it will not restart until manually started again.
- `baby-tools-shop`: The name of the Docker image used to create the container.
``` bash
docker run -d --env-file .env -p 8025:8025 --restart=always baby-tools-shop
```



### Step 6: Checking the application
Call the server `IP` with port `8025` in the browser:
``` bash
http://<ip_adress>:8025/
```



### Step 7: Create a superuser 'Admin'
1. Find out the container ID
``` bash
docker ps
```

2. This command allows you to start an interactive Bash session inside a running Docker container. Replace `<CONTAINER_ID>` with the actual container ID or name.
``` bash
docker exec -it <CONTAINER_ID> /bin/bash
```

3. Create superuser in Django
``` bash
python manage.py createsuperuser
```

4. Follow the instructions to enter your user `name`, `e-mail` and `password`.
``` bash
Enter the required information:
Username (leave blank to use 'root'): admin
Email address: admin@test.de
Password: ********
Password (again): ********
Superuser created successfully.
```

5. Call up the admin panel:
``` bash
http://ip_adress:8025/admin
```
> [!Note]
> Log in with the superuser account you just created.



### Step 8: After you have logged in, you can add some products to avoid seeing a blank page after publication. And to check if it worked.
    python manage.py migrate
    
        

to update the database schema.

## Configuration

1. **ALLOWED_HOSTS**

Django must be told which hostnames or IP addresses are allowed to serve the application.  
For a simple setup with an environment variable `SERVER_IP`, you can configure `ALLOWED_HOSTS` as shown in [Usage, Step 2](#step-2-open-the-settingspy-in-babyshop_app-and-add-this-to-allowed-host).

- For local development, `localhost` and `127.0.0.1` are usually sufficient.  
- For deployment on a server, add your own server IP or domain name to `ALLOWED_HOSTS` (never commit real IPs or secrets to the repository)


2. **Environment variables**

Optionally you can use environment variables (for example `SERVER_IP`) to configure values inside `settings.py`.  
Secrets such as passwords or tokens must not be stored in the repository.

3. **Database**

- Default database: SQLite (`db.sqlite3`) in the project root.  
- To use another database, adjust the `DATABASES` configuration in `settings.py` and add the required driver to `requirements.txt`.

## Deploying with Docker

This section describes how to deploy the application with Docker on your VM (for example `116.203.194.189`).

1. **Copy or clone the project on the VM**

     ```bash
    cd ~/projects
    git clone https://github.com/ibog1/baby-tools-shop.git
    cd baby-tools-shop
     ```


2. **Build the Docker image**

     ```bash
    docker build -t babyshop_app .
     ```


- Builds an image based on the `Dockerfile` in the repository.  
- Installs all dependencies from `requirements.txt`.  
- Prepares the Django project for running inside a container.

3. **Run the Docker container**

     ```bash
    docker run -d -p 8025:8025 --name babyshop_container babyshop_app
     ```

- Runs the container in detached mode.  
- Maps port `8025` on the host to port `8025` in the container.  
- Names the container `babyshop_container` for easier management.

4. **Access the application on the VM**

- Application: `http://<SERVER_IP>:8025`  
- Admin panel: `http://<SERVER_IP>:8025/admin`

5. **Create a superuser inside the container (if not already created)**


     ```bash
    docker exec -it babyshop_container python babyshop_app/manage.py createsuperuser
     ```

After creating the superuser you can log in at `/admin` and manage products, categories and users.


### Hints

This section will cover some hot tips when trying to interacting with this repository:

- Settings & Configuration for Django can be found in `babyshop_app/babyshop/settings.py`
- Routing: Routing information, such as available routes can be found from any `urls.py` file in `babyshop_app` and corresponding subdirectories

### Photos

##### Home Page with login

<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080815407.jpg"></img>
##### Home Page with filter
<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080840305.jpg"></img>
##### Product Detail Page
<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080934541.jpg"></img>

##### Home Page with no login
<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080953570.jpg"></img>


##### Register Page

<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323081016022.jpg"></img>


##### Login Page

<img alt="" src="https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323081044867.jpg"></img>
