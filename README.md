# Baby Tools Shop

The **Baby Tools Shop** is a Django-based web application that allows users to browse and manage baby products.  
The project is containerized with Docker and can be run locally on a developer machine or on a virtual server (VM) using the same Docker image.

## Table of Contents

1. [Technologies](#technologies)
2. [Quickstart](#quickstart)
3. [Usage](#usage)
4. [Configuration](#configuration)
5. [Hints](#hints)


## Technologies

The application uses the following technologies:

- **Python** 3.9** as the programming language.  
- **Django** 4.0.2** for the web framework.  
- **Docker** for containerization and deployment.  
- **venv** for managing the local virtual environment.

## Quickstart

### Prerequisites

Before you start, make sure the following tools are installed:

- Git, to clone the repository.
- Docker (including the Docker CLI), to build and run the application container.


1. **Clone the repository**

    ```bash
   git clone https://github.com/ibog1/baby-tools-shop.git
   cd baby-tools-shop
   ```

   
> [!IMPORTANT]
> Create a `.env` file from `example.env` and adjust the values for your environment.
> This file contains sensitive data (e.g. secret key, database credentials) and must **not** be committed to the repository.

   ```bash
   cp example.env .env
   ```
then open .env and set your own values


2. **Build the Docker image**

   ```bash
   docker build -t babyshop_app .
   ```

3. **Run the container**

   ```bash
   docker run -d -p 8025:8025 --name babyshop_container babyshop_app
   ```

4. **Access the application**

- Application: `http://localhost:8025`
- Admin panel: `http://localhost:8025/admin`

> Note: Creating a Django superuser is not required for the Quickstart.  
> Details on how to create and use an admin account can be found in the Usage section.

## Usage

This section describes the way to run and configure the Baby Tools Shop beyond the Quickstart.

### Running the container on a remote VM

To deploy the application on a remote VM (e.g. a cloud server):

1. SSH into the VM and clone the repository:

      ```bash
     git clone https://github.com/ibog1/baby-tools-shop.git
     cd baby-tools-shop
     ```

2. Build the image and start the container on the VM:

   ```bash
   docker build -t babyshop_app .
   docker run -d -p 8025:8025 --name babyshop_container babyshop_app
   ```

3. Access the shop from your local machine using the public IP of the VM:

- Application: `http://<VM_IP>:8025`
- Admin panel: `http://<VM_IP>:8025/admin`

### Optional: create a Django superuser

Creating a Django superuser is only needed if you want to log into the admin panel

1. Open a shell inside the running container:
     
     ```bash
     docker exec -it babyshop_container bash
     ```


2. Inside the container, create a superuser:

     ```bash
     cd babyshop_app
     python manage.py createsuperuser
     ```

3. Follow the instructions to enter your user `name`, `e-mail` and `password`.

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
http://<VM_IP>:8025
```
> [!Note]
> Log in with the superuser account you just created.

5. After you have logged in, you can add some products to avoid seeing a blank page after publication. And to check if it worked.

     ```bash
    python manage.py migrate
    ```
     
to update the database schema.

## Configuration

1. ALLOWED_HOSTS and SECRET_KEY

Django reads sensitive configuration from environment variables defined in a `.env` file.  
In `settings.py`, `SECRET_KEY` and `ALLOWED_HOSTS` are loaded from `DJANGO_SECRET_KEY` and `DJANGO_ALLOWED_HOSTS`.

- For local development you can use values like `localhost,127.0.0.1` in `DJANGO_ALLOWED_HOSTS`.  
- For deployment on a server you should add your server IP or domain name to `DJANGO_ALLOWED_HOSTS` and never commit real IPs or secrets directly to the repository.

2. Environment variables

Configuration values are provided via a `.env` file in the project root (next to `manage.py`).  
An `example.env` file is included in the repository and documents all required keys; copy it to `.env` and replace the placeholder values with your own secrets.

3. Database

- Default database: SQLite (`db.sqlite3`) in the project root, which requires no additional configuration.  
- To use another database, adjust the `DATABASES` setting in `settings.py` and add the appropriate database driver to `requirements.txt` (for example, a PostgreSQL or MySQL client library).

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
