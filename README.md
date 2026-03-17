# Karate DSL - Automatización de Pruebas

## Requisitos previos
- Java JDK 11 o superior
- Maven 3.6 o superior

## Cómo ejecutar los tests

### Ejecutar todos los tests
```bash
mvn test
```

### Ejecutar un feature específico
```bash
mvn test -Dkarate.options="classpath:Usuarios/Login.feature"
```

## Estructura del proyecto
```
src/test/java/
├── Usuarios/
│   ├── Login.feature
│   ├── Registrar.feature
│   ├── BuscarUsuario.feature
│   ├── Usuarios.feature
│   └── LoginRunner.java
├── features/lobby/
│   └── PruebaTest.java
├── karate-config.js
└── logback-test.xml
```

## Reportes
Los reportes se generan automáticamente en:
`target/karate-reports/karate-summary.html`