# Use an official PHP runtime
FROM php:7.2-apache

ENV ACCEPT_EULA=Y

#Install required packages for SQL Server package Driver
RUN apt-get update && apt-get install -y gnupg2
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get -y install msodbcsql17 unixodbc-dev

# Install PHP SQLSRV extensions ( 5.2.0 version brings compatibility with php 7.2 )
RUN pecl install sqlsrv-5.2.0
RUN pecl install pdo_sqlsrv-5.2.0
RUN docker-php-ext-enable sqlsrv pdo_sqlsrv

# Enable Apache modules
RUN a2enmod rewrite

# Install any extra extensions you need
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Set the working directory to /var/www/html
WORKDIR /var/www/html