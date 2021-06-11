# TFG-FTA-Aida-Garc-a_An-lisis-Anomal-as-Magn-ticas
Este repositorio contiene los códigos de MatLab diseñados para el análisis de anomalías magnéticas por medio del Método del Centroide (CM). Incluye además cálculo de errores, ajustes, códigos de subdivisión de retículos, cómputos del mapa de la isoterma de Curie a partir de los anteriores y del flujo de calor superficial derivado de esta última.
El código que inicializa el tratamiento de los datos es el etiquetado con 'código principal': realiza la extracción de las magnitudes de interés del documento de datos, las limpia, interpola los valores de anomalía
y proyecta los mapas 2D y 3D de las anomalías. Proporciona una primera intuición de los datos. El orden lógico (necesario, porque requieren de variables de cada código antecesor) de ejecución de los códigos es:

En segundo lugar, la transformada de Fourier y el promedio radial de la misma se ejecuta desde el archivo funcion 'promrad', que tiene como variables de entrada  (1) la matriz de 
anomalías (interpoladas), que hace las veces de función campo magnético con dependencia espacial, y (2) la resolución de los datos (fundamental). Proporciona el vector de onda k, adicionalmente
por si fuera de interés también la longitud de onda l, y el promedio radial. Esto es
[k,l,P]=promrad(anomalías,resolución)

El ajuste de las regiones de interés para la aplicación concreta del Método del Centroide lo realiza el script 'ajustezt_z0'. Computa las profundidades superficial, central y basal de la capa
de anomalía magnética y proyecta los ajustes. La función del código 'errores' es evidente.

El código de 'reticulos_final' subdivide la región de estudio de las anomalías para obtener estimaciones locales de la profundidad basal y así proyectar un mapa 2D de la isoterma de Curie. 
y el código de 'flujo_calor', en último lugar, computa una ecuación básica a partir de la CPD para proporcionar otro mapa 2D del flujo de calor superficial.
