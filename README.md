# Monolith System for Work Attendance

## Overview
The monolith system is a web-based solution that serves as the backend and frontend for managing work attendance. This system interacts with the Arduino BLE system and uses the employee’s mobile device MAC address as a unique identifier. The backend handles business logic and API endpoints, while the frontend provides a user-friendly interface for administrative tasks.

### Key Features:
- Centralized management of employee records.
- Authentication using mobile device MAC addresses.
- RESTful API endpoints for integration with external systems.
- CRUD operations for employee data.

---

## How It Works

1. **Backend API**:
   - **Login Endpoint**:
     - Validates the MAC address and employee code.
     - Manages active and logged-in status.
   - **Logout Endpoint**:
     - Handles session termination for employees.

2. **Frontend**:
   - Web interface for:
     - Viewing and managing employee records.
     - Monitoring login/logout activity.

3. **Integration**: Mobile devices connect to the Arduino BLE system to establish the employee’s presence. Once the connection is confirmed, the mobile app consumes the backend’s login endpoint to send the employee’s MAC address and validate the session.

---

## Backend Code Explanation

### Core Functionalities

#### `FuncionarioAction` Class
- Provides actions for employee management, such as:
  - Preparing data for forms.
  - Persisting employee records.
  - Listing and deleting records.

Key methods:
- `prepareFuncionario`: Prepares the employee object for viewing or editing.
- `persistFuncionario`: Saves new or updated employee records.
- `deleteFuncionario`: Deletes an employee record while ensuring data integrity.
- `listFuncionario`: Fetches a list of all employees for display.

#### `FuncionarioRestful` Class
- Defines RESTful endpoints for login and logout processes.

Key methods:
- `login`: Validates the employee’s MAC address and code, updating the active and logged-in status as needed.
- `logout`: Terminates the employee’s session.

Example snippet for login:
```java
@Path("/login")
@POST
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public Response login(FuncionarioDto funcionarioDto) {
    try {
        Funcionario funcionario = funcionarioBo.loadByCodigo(funcionarioDto.getCodigo());
        if (funcionario == null)
            return Response.status(Response.Status.FORBIDDEN).entity("CodeErro").build();

        if (funcionario.isLogado()) {
            if (!funcionarioBo.checkDevices(funcionarioDto.getEnderecoMacDevices(), funcionario)) {
                if (funcionario.isAtivo()) {
                    funcionario.setAtivo(false);
                    funcionario.setLogado(false);
                    funcionarioBo.persist(funcionario);
                    funcionarioBo.removeDevicesByCode(funcionarioDto.getEnderecoMacDevices(), funcionario);
                    return Response.status(Response.Status.ACCEPTED).build();
                }
                funcionario.setAtivo(true);
                funcionarioBo.persist(funcionario);
                return Response.status(Response.Status.CONFLICT).build();
            }
            funcionario.setAtivo(false);
            funcionario.setLogado(false);
            funcionarioBo.persist(funcionario);
            funcionarioBo.removeDevicesByCode(funcionarioDto.getEnderecoMacDevices(), funcionario);
        } else {
            funcionario.setAtivo(false);
            funcionarioBo.persist(funcionario);
            funcionarioBo.storesDevicesByCode(funcionarioDto.getEnderecoMacDevices(), funcionario);
        }

        return Response.status(Response.Status.OK).build();
    } catch (Exception e) {
        e.printStackTrace();
        return Response.serverError().build();
    }
}
```

---

## Frontend Features
- **Employee Management**:
  - Forms for adding or editing employee details.
  - List view for searching and filtering records.

- **Activity Monitoring**:
  - Dashboard displaying logged-in and active employees.
  - Notifications for login/logout events.

---

## Setup and Installation

### Prerequisites
- Java Development Kit (JDK 8 or higher).
- Apache Tomcat server.
- MySQL or other relational database.
- Maven for dependency management.

### Steps
1. **Database Configuration**:
   - Set up the database with tables for employee data and sessions.

2. **Backend Deployment**:
   - Build the project using Maven:
     ```bash
     mvn clean install
     ```
   - Deploy the generated WAR file to the Tomcat server.

3. **Frontend Deployment**:
   - Ensure the frontend files are in the appropriate directory within the Tomcat webapps folder.

4. **Configuration**:
   - Update the database connection settings in `application.properties` or equivalent.

---

## Testing and Usage
- **API Testing**:
  - Use tools like Postman to test the login and logout endpoints.
  - Example payload for login:
    ```json
    {
      "codigo": "EMP123",
      "enderecoMacDevices": "00:14:22:01:23:45"
    }
    ```

- **Frontend**:
  - Access the web interface via the configured URL (e.g., `http://localhost:8080/app`).
