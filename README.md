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

- Application: <http://127.0.0.1:8025/>  
- Admin panel: <http://127.0.0.1:8025/admin>

## Usage

Once the server is running (locally or in Docker), you can use the application as follows:

- Open the start page to view available product categories and products.  
- Use the navigation to switch between pages (home, categories, login/logout, etc.).  
- Log in with your superuser account or a normal user account.  
- As an admin user, open `/admin` to:
- Create and edit categories  
- Create and edit products (including images)  
- Manage users and permissions  

If you add or change models, run:

     ```bash 
    python manage.py makemigrations
    python manage.py migrate   
    ```

to update the database schema.

## Configuration

1. **ALLOWED_HOSTS**

In production the application is served from the VM with IP `116.203.194.189` on port `8025`.  
In `babyshop_app/babyshop/settings.py`:

     ```bash
    ALLOWED_HOSTS = [
    "116.203.194.189",
    "127.0.0.1",
    "localhost",
    ]
     ```

- Replace `116.203.194.189` with your own server IP if you deploy to a different host.

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

- Application: `http://116.203.194.189:8025`  
- Admin panel: `http://116.203.194.189:8025/admin`

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
