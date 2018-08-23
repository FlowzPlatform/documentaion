# Generate a certificate signing request (CSR) for your Apache Web server.

### (1) Log in to your server's terminal (SSH).

### (2) At the prompt, type the following command:

```
openssl req -new -newkey rsa:2048 -nodes -keyout yourdomain.key -out yourdomain.csr
```
![selection_075](https://user-images.githubusercontent.com/28925482/44532205-2c56c700-a710-11e8-89cc-8fbfaa6baec8.png)

### (3) Enter the requested information from:
```
Common Name
Organization
Organization Unit
City or Locality
State or Province
Country
```
