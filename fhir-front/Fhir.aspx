<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Fhir.aspx.cs" Inherits="Fhir" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/fhir-client.js"></script>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous" />
    <script
        src="https://code.jquery.com/jquery-3.3.1.js"
        integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
        crossorigin="anonymous"></script>
    <script>

        $(document).ready(function () {
            $("#buscar").click(function (event) {
                event.preventDefault();
            });
             $("#siguiente").click(function (event) {
                event.preventDefault();
            });
             $("#previo").click(function (event) {
                event.preventDefault();
            });

            buscarTodo();

        });
        var smart = new FHIR.client({
            serviceUrl: 'http://10.10.100.9/fhir-nivel2/baseDstu3',
            //serviceUrl: '	http://fhir.cens.cl/baseDstu3',
            auth: {
                type: 'none'
            },

        });

        var patientsGlobal;
        function buscarTodo() {
            smart.api.search({ type: "Patient", query: {} }).then(function (r) {
                if (r === null)
                    return;
                var txtStr = '';
                patients = r;
                patientsGlobal = patients;
                console.log(patients)
                for (var i = 0; i < patients.data.entry.length; i++) {
                    //console.log(patients.data.entry[i].resource.id)
                    txtStr = txtStr + '<tr><td>' + patients.data.entry[i].resource.identifier[0].value + '</td><td>' + patients.data.entry[i].resource.gender + '</td><td>' + patients.data.entry[i].resource.name[0].given + ' ' + patients.data.entry[i].resource.name[0].family + '</td></tr>';
                }
                if (txtStr != null && txtStr != '') {
                    txtStr = '<table class="table table-bordered table-striped" ><thead><tr><th>RUN</th><th>Genero</th><th>Full Name</th></thead><tbody>' + txtStr + '</tbody></table>';
                }

                document.getElementById('tabla').innerHTML = txtStr;

                //console.log(JSON.stringify(r, null, 2));

            });
        }

        function buscarSiguiente() {
            var lnk = patientsGlobal.data.link[1].url;
            console.log(lnk);
            smart.api.search({ query: { lnk } }).then(function (r) {
                console.log(r);
                if (r === null)
                    return;
                var txtStr = '';
                patients = r;
                patientsGlobal = patients;
                console.log(patients)
                for (var i = 0; i < patients.data.entry.length; i++) {
                    //console.log(patients.data.entry[i].resource.id)
                    txtStr = txtStr + '<tr><td>' + patients.data.entry[i].resource.identifier[0].value + '</td><td>' + patients.data.entry[i].resource.gender + '</td><td>' + patients.data.entry[i].resource.name[0].given + ' ' + patients.data.entry[i].resource.name[0].family + '</td></tr>';
                }
                if (txtStr != null && txtStr != '') {
                    txtStr = '<table class="table table-bordered table-striped" ><thead><tr><th>RUN</th><th>Genero</th><th>Full Name</th></thead><tbody>' + txtStr + '</tbody></table>';
                }

                document.getElementById('tabla').innerHTML = txtStr;

                //console.log(JSON.stringify(r, null, 2));

            });
        }




        function buscarRun() {
            //smart.api.search({type: "Patient", query: {given: ["John", "Bob"], family: "Smith"})

            if ($("#run").val() !== '' && $("#gender").val() !== '' &&  $("#gender").val() !== 'Choose...'  ) {
                console.log('estoy en run')
                console.log($("#run").val())
                smart.api.search({ type: "Patient", query: { identifier: $("#run").val(), gender: $("#gender").val() } }).then(function (r) {

                    patients = r;
                    patientsGlobal = patients;
                    console.log(patients);
                    if (patients.data.total === 0) {
                        alert("no existen registros");
                        return;
                    };
                    var txtStr = '';
                 
                    //console.log(patients)
                    for (var i = 0; i < patients.data.entry.length; i++) {
                        //console.log(patients.data.entry[i].resource.id)
                        txtStr = txtStr + '<tr><td>' + patients.data.entry[i].resource.identifier[0].value + '</td><td>' + patients.data.entry[i].resource.gender + '</td><td>' + patients.data.entry[i].resource.name[0].given + ' ' + patients.data.entry[i].resource.name[0].family + '</td></tr>';
                    }
                    if (txtStr != null && txtStr != '') {
                        txtStr = '<table class="table table-bordered table-striped" ><thead><tr><th>RUN</th><th>Genero</th><th>Full Name</th></thead><tbody>' + txtStr + '</tbody></table>';
                    }

                    document.getElementById('tabla').innerHTML = txtStr;

                    //console.log(JSON.stringify(r, null, 2));

                });
            }
            else if ($("#run").val() !== '') {
                console.log('estoy en run')
                console.log($("#run").val())
                smart.api.search({ type: "Patient", query: { identifier: $("#run").val() } }).then(function (r) {
              
                    var txtStr = '';
                    patients = r;
                    patientsGlobal = patients;
                     if (patients.data.total === 0) {
                        alert("no existen registros");
                        return;
                    };
                    //console.log(patients)
                    for (var i = 0; i < patients.data.entry.length; i++) {
                        //console.log(patients.data.entry[i].resource.id)
                        txtStr = txtStr + '<tr><td>' + patients.data.entry[i].resource.identifier[0].value + '</td><td>' + patients.data.entry[i].resource.gender + '</td><td>' + patients.data.entry[i].resource.name[0].given + ' ' + patients.data.entry[i].resource.name[0].family + '</td></tr>';
                    }
                    if (txtStr != null && txtStr != '') {
                        txtStr = '<table class="table table-bordered table-striped" ><thead><tr><th>RUN</th><th>Genero</th><th>Full Name</th></thead><tbody>' + txtStr + '</tbody></table>';
                    }

                    document.getElementById('tabla').innerHTML = txtStr;

                    //console.log(JSON.stringify(r, null, 2));

                });
            }
            else if ($("#gender").val() !== '') {


                if ($("#gender").val() == "Choose...") {
                    buscarTodo();
                }
                else {
                    console.log('estoy en gender')
                    console.log($("#gender").val())
                    smart.api.search({ type: "Patient", query: { gender: $("#gender").val() } }).then(function (r) {
                        
                        var txtStr = '';
                        patients = r;
                        patientsGlobal = patients;
                         if (patients.data.total === 0) {
                        alert("no existen registros");
                        return;
                    };
                        //console.log(patients)
                        for (var i = 0; i < patients.data.entry.length; i++) {
                            //console.log(patients.data.entry[i].resource.id)
                            txtStr = txtStr + '<tr><td>' + patients.data.entry[i].resource.identifier[0].value + '</td><td>' + patients.data.entry[i].resource.gender + '</td><td>' + patients.data.entry[i].resource.name[0].given + ' ' + patients.data.entry[i].resource.name[0].family + '</td></tr>';
                        }
                        if (txtStr != null && txtStr != '') {
                            txtStr = '<table class="table table-bordered table-striped" ><thead><tr><th>RUN</th><th>Genero</th><th>Full Name</th></thead><tbody>' + txtStr + '</tbody></table>';
                        }

                        document.getElementById('tabla').innerHTML = txtStr;

                        //console.log(JSON.stringify(r, null, 2));

                    });
                }

            }
        }

        function buscarGender() {
            //smart.api.search({type: "Patient", query: {given: ["John", "Bob"], family: "Smith"})
            console.log('estoy en gender')
            console.log($("#gender").val())

        }


</script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-sm">
                    <label for="run">Run</label>
                    <input type="text" id="run" placeholder="Run">
                </div>
                <div class="col-sm">
                    <label for="gender">Gender</label>
                    <select id="gender">
                        <option selected>Choose...</option>
                        <option value="female">Female</option>
                        <option value="male">Male</option>
                    </select>
                </div>
                <div class="col-sm">
                    <button id="buscar" onclick="buscarRun()">Buscar</button>
                </div>

            </div>
        </div>
        <div id="tabla">
        </div>

        <div class="container">
            <div class="row">
                <div class="col-sm">
                     <button id="previo" onclick="buscarPrevio()"><<</button>
                </div>
                <div class="col-sm">
                   
                </div>
                <div class="col-sm">
                    <button id="siguiente" onclick="buscarSiguiente()">>></button>
                </div>

            </div>
        </div>

    </form>



</body>
</html>
