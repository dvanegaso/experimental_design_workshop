## Taller de diseño experimental.

Para la página del taller accede al link:

https://dvanegaso.github.io/experimental_design_workshop/

En el taller vas a encontrar los siguientes contenidos:

- Diseño Completamente Aleatorizado.
- Diseño en Bloques Completamente Aleatorizado.
- Diseño en Cuadro Latino.

Cada página muestra explicaciones sobre los diseños. Las pruebas estadísticas se muestran en el código `funciones.R` de manera accesible. 

## Pruebas

Para pruebas de normalidad en este código se aplicaron las siguientes:

- `shapiro.test()`: Es la prueba más usual dentro de estadística.
- `ad.test()`: Del paquete `nortest`. Es la más recomendable para pruebas con pocos datos.
- `lillie.test()`: Tambien del paquete `nortest`, es una alternativa muy utilizada.

En general se deben manejar varias pruebas ya que las pruebas de normalidad son de baja potencia. Tambien se recomienda hacer uso del gráfico QQ-plot para los residuales, así como graficar los modelos (con solo la instrucción `plot()` de R base se pueden hacer diagnosticos de modelos).

Por otro lado, para las pruebas de homocedasticidad de residuos se recomienda usar la prueba de Levene (`levene.test()`) del paquete `car`; ya que no pierde tanta potencia ante la no normalidad. En caso de probarse la normalidad de residuales, se recomienda tambien la prueba usual de Bartlett `bartlett.test()`.

