%Promedio radial del espectro de potencia 
%promrad

%ENTRADAS 
% 1. Matriz con los valores del campo magnético (residuo) como función de las
% coordenadas (dependencia espacial)
%(hemos interpolado los valores)
%2. Resolución espacial de las señales


%SALIDAS
%Devuelve el rango de vectores de onda k, computa directamente también las
%longitudes de onda
%Pf = será el promedio radial del espectro de potencia

function [k,l,P]=promrad(z,res); 

%Ajustamos los parámetros del tamaño de la matriz de datos
[n m]=size(z);
dim=n*m;

%Convertimos la dependencia espacial al dominio de las frecuencias mediante
%la Transformada de Fourier 
FT=fftshift(fft2(z));     %Transformada de Fourier centrada en torno al 0 

%Aplicamos fft2 para hacer la transformada, y después simetrizamos la matriz centrando el 0 en el conjunto de datos
%fft2 es una prefunción de MatLab '2D-fast Fourier Transform'
%fftshift: shift zero-frequency component to the center of spectrum. Nos
%interesa por cuestiones de simetría radial posteriores al promediar (vamos
%a cambiar a coordenadas polares (2D))

%Normalizamos lo anterior (en principio nos conviene tenerlo)
FT_norm=(abs(FT)/dim).^2; 


%Diseñamos el tamaño del espectro de potencia que vamos a calcular.
%Queremos trabajar con una dominio cuadrado 
min_dim=min(n,m);
max_dim=max(n,m);
dif=abs(n-m); %diferencia de dimensiones

%Vamos a cuadrar el dominio espacial para trabajar mejor radialmente,
%añadiendo más filas o columnas (con NaN) según falten para completar el
%dominio. Posteriormente, cuando hagamos el promedio radial daremos la
%orden de ignorar los NaN 

%También podríamos acogernos a la menor de las dimensiones, pero dejamos
%fuera demasiada información 

%Cuadramos 
if n>m    %hay más filas que columnas
    FT_norm=[NaN(n,floor(dif/2)) FT_norm NaN(n,floor(dif/2)+1)];
    %añadimos simétricamente a cada lado las columnas que falten para tener
    %una matriz de datos cuadrada
elseif n < m  %hay más columnas que filas
    FT_norm=[NaN(floor(dif/2),m); FT_norm; NaN(floor(dif/2)+1,m)];  %añadimos filas arriba y abajo 
end




 

%% Computamos el promedio radial del espectro de potencias 

%En otros códigos dicen coger sólo la mitad del espectro de potencias
%debido a simetría

[x y]=meshgrid(-max_dim/2:max_dim/2-1, -max_dim/2:max_dim/2-1);  %mallado cartesiano  (%revisar los límites)
[theta rho]=cart2pol(x,y);  %convertir a ejes en coordenadas polares 
rho=round(rho);
i=cell(floor(max_dim/2)+1,1);
for r=0:floor(max_dim/2)
    i{r+1}=find(rho==r);
end
P=zeros(1,floor(max_dim/2)+1);
for r = 0:floor(max_dim/2)
    P(1,r+1)=nanmean(FT_norm(i{r+1}));    %nanmean hace la media ignorando los NaN
end 


%% SET UP para el gráfico 

semi_dim=floor(max_dim/2)+1;



xmin = 0; %No negative image dimension 
xmax=ceil(log10(semi_dim));    %con nuestros datos xmax=3

f=linspace(0,xmax,length(P)); %fijamos las abcisas 

%¿Por qué 0.8? %En otros codigos fijan xmax

rangox=(xmin:xmax);   %rango de las x 
ymin=floor(log10(min(P)));
ymax=ceil(log10(max(P)));
rangoy=(ymin:ymax);   %rango de las y 


%Creamos etiquetas de los ejes del gráfico
Lx=length(rangox);
Ly=length(rangoy);

xCell = cell(1:Lx);
for i=1:Lx
    xRangeS=num2str(10^(rangox(i))*res);    %num2str = convierte números a arrays de caracteres
    xCell(i)=cellstr(xRangeS);      %convierte a celdes el array de caracteres
end 

%Idem con la y

yCell=cell(1:Ly);
for i=1:Ly
    yRangeS=num2str(rangoy(i));
    yCell(i)=strcat('10e',cellstr(yRangeS));
end 
 
%Introducimos la resolución espacial de los datos 
res=sqrt(2)*res;  %ajustamos la resolución radialmente
f = f./(res);  
%definimos la equivalencia al vector de onda 
k=(2*pi)*f;     %c=1
l=1./k;     %longitud de onda %l=2*pi./k;

figure(3)
loglog(l,log(P))
xlabel('Longitud de onda \lambda [km^{-1}]')
ylabel('ln(\Phi_{\Delta T}(|k|))')
title('Promedio radial del espectro de potencia vs. longitud de onda')


figure(4) 
loglog(k,log(P))
xlabel('Numero de onda k [rad km^{-1}]')
ylabel('ln(\Phi_{\Delta T}(|k|)')
title('Promedio radial del espectro de potencia vs. numero de onda')

figure(5) 
loglog(k,log(sqrt(P)))
xlabel('Numero de onda k [rad km^{-1}]')
ylabel('ln(\Phi_{\Delta T}(|k|)^{1/2})')
title('Ln Radially Averaged Power Spectrum vs. wavenumber k')

figure(6) 
loglog(l,log(sqrt(P)))
xlabel('Longitud de onda \lambda [rad km^{-1}]')
ylabel('ln(\Phi_{\Delta T}(|k|)^{1/2})')
title('Ln Radially Averaged Power Spectrum vs. wavelength \lambda')
    



