%Código principal 

                                            
format long

%Cargamos archivo ASCII (.txt) con los datos de MGD (via NOAA)

MGD77_960774=readtable('datos','TreatAsEmpty',{'NaN'});

MGD77_960774 = MGD77_960774; 

%Lectura de datos del fichero cargado 

LAT_=table2array(MGD77_960774(:,5));   %Latitud
LON_=table2array(MGD77_960774(:,6));   %Longitud
MAG_TOT_=table2array(MGD77_960774(:,14));   %Campo total medido
MAG_RES_=table2array(MGD77_960774(:,16));   %residuo magnético
SUR_=table2array(MGD77_960774(:,1)); %identificamos tb la expedición
T_=table2array(MGD77_960774(:,3));   %años


%Vamos a homogeneizar LAT, LON y MAG_RES, poniendo ceros en las coordenadas
%en las que no haya medicion de residuo (MAG_RES). Si no aplicamos rmmissing, tiene las 61637
%coordenadas de los demas

for i=1:size(LAT_)
    if isnan(MAG_RES_(i)) == 1
        LAT_(i)= 0;   %ponemos ceros en las lats y lons con MAG_RES mala
        LON_(i)= 0;
        MAG_RES_(i)=0; 
    end 
end 

%Ahora construimos vectores LAT y LON quitándoles los 0's.

LAT=zeros(16594,1);
LON=zeros(16594,1);
MAG_RES=zeros(16594,1);

j=0;
for i=1:size(LAT_)
    if abs(LAT_(i))>0
        j=j+1;
        LAT(j)=LAT_(i);
        LON(j)=LON_(i);
        MAG_RES(j)=MAG_RES_(i);
    end
end

%Aquí tenemos vectores LAT,LON,MAG_RES limpios y correspondientes a aprox
%16594 entradas validas


%Definición de un plano cartesiano nuevo para la interpolación de los
%datos, que sirve a la construcción del mapa 2D de anomalias

%El mallado que me gusta (al trabajar sólo con las seleccionadas no tira)
x=linspace(-77,-83,length(LON)*0.05);
y=linspace(14,11,length(LAT)*0.05);
[X,Y]=meshgrid(x,y);


dx=4830;   %Espaciado en metros en la dirección x   %al disminiuir dx aumenta la precisión en el tratamiento posterior
dy=2300;  %Espaciado en metros en la dirección y 
%resolucion horizontal media = 0.045º aprox = 5 km (sobre el ecuador)
%resolucion vertical media



%Interpolacion vecino cercano: convierte una malla irregular a regular
F=scatteredInterpolant(LON,LAT,MAG_RES,'natural');
Z=F(X,Y);   %Anomalías magnéticas de la malla regularizada 

%Representamos gráficamente el mapa de anomalías magneticas en 3D
mesh(X,Y,Z)   %No es interesante porque apenas tiene detalle (usar
%Surfer)


%Representamos gráficamente el mapa de anomalías magnéticas en 2D
figure(2)
imagesc(X(1,:),Y(:,1),Z,'CDataMapping','scaled');
set(gca,'YDir','normal');  %Para dar la vuelta a la imagen, que estará al revés 
title('Mapa 2D de anomalías magnéticas')
xlabel('Longitud');
ylabel('Latitud');

figure(3) 
contour(Z)



%Hasta aquí, tenemos el código de lectura de datos y proyección en MatLab.
%Mapa de anomalias 2D = Imagen que vamos transformar con Fourier

%El dato más relevante obtenido es Z, que se corresponde con una matriz con
%los valores (interpolados) de los mag_res, equivalente a la función del
%campo total de anomalías magnéticas (como función de coordenadas espaciales)

%En otro script, llamaremos al script de PSD para determinar los valores de potencia y
%obtener el promedio radial del espectro de potencia PARA LA IMAGEN 


