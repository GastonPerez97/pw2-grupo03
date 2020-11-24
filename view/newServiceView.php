{{> headerWithSidebar}}

<div class="w3-content w3-margin-top">
    <form action="addNewService" method="post" class="login-form">
        <div class="container-title"><p>Nuevo Servicio</p></div>

        <div class="container">
            <div class="w3-margin-bottom">
                <a href="/pw2-grupo03/service" class="w3-button w3-blue w3-small w3-round text-decoration-none">Volver</a>
            </div>

            <label for="numberVehicle"><b>N° Unidad <span style="color: red">*</span></b></label>
            <input type="number" placeholder="Ingresar número de unidad" name="numberVehicle" class="login-input" required>

            <label for="serviceDate"><b>Fecha Service <span style="color: red">*</span></b></label>
            <input type="date" name="serviceDate" class="login-input" required>

            <label for="kilometers"><b>Kilometros <span style="color: red">*</span></b></label>
            <input type="number" placeholder="Ingresar kilometros de la unidad" name="kilometers" class="login-input" required>

            <label for="mechanic"><b>ID Mecánico <span style="color: red">*</span></b></label>
            <input type="number" placeholder="Ingresar ID del mecánico" name="mechanic" class="login-input" required>

            <label for="description"><b>Descripción <span style="color: red">*</span></b></label>
            <input type="text" placeholder="Ingresar detalle del service" name="description" class="login-input" required>

            <label for="cost"><b>Costo <span style="color: red">*</span></b></label>
            <input type="number" placeholder="Ingresar costo" name="cost" class="login-input" required>

            <button class="form-button w3-round w3-green w3-margin-top" type="submit">Registrar</button>
        </div>
    </form>
</div>

{{> footerSidebarFixed}}
