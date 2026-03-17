  
   @eliminarUsuario
Feature: DELETE /usuarios/{_id} - Eliminar usuario en ServeRest
  Como administrador del sistema
  Quiero eliminar un usuario por su ID
  Para gestionar los usuarios registrados

  Background:
    * url 'https://serverest.dev'
    * header Content-Type = 'application/json'

  @happy @smoke
  Scenario: Eliminar usuario existente devuelve 200
    * def email = 'eliminar_' + java.lang.System.currentTimeMillis() + '@qa.com'
    Given path '/usuarios'
    And request
      """
      {
        "nome":          "Usuario Eliminar",
        "email":         "#(email)",
        "password":      "teste123",
        "administrador": "true"
      }
      """
    When method POST
    Then status 201
    * def usuarioId = response._id

    Given path '/usuarios/' + usuarioId
    When method DELETE
    Then status 200
    And match response.message == "Registro excluído com sucesso"

 /* @validacion
 /* Scenario: Eliminar usuario con ID inexistente devuelve 200
   77 Given path '/usuarios/idquonoexiste123'
   77 When method DELETE
  77  Then status 200
   /* And match response.message == "Nenhum registro excluído"




