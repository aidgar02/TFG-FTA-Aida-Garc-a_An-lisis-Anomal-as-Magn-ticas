%errores 

%Se apoya sobre el programa %ajustezt_z0 en el que se han definido las
%variables que aquí se comparan. En caso de no haberlo ejecutado ya: 
%run ajustezt_z0


%%
%Valores 'reales' del espectro

Y_Zt;  %calculado en el programa de ajustes. Se corresponde con los valores del logaritmo del espectro en el rango de frecuencias de interés
Y_Z0;  %calculado en ajustezt_z0. Valores de ln(sqrt(espectro de potencia)/k) en el rango de interes


%%
%Valores derivados del ajuste

Zt_ajuste=polyval(ajusteZt,X_Zt); 
Z0_ajuste=polyval(ajusteZ0,X_Z0);


%%
%Diferencias entre ambos 

dif_Zt=Y_Zt-Zt_ajuste;
errorZt=mean(dif_Zt);
desv_estZt=std(dif_Zt)./(max(X_Zt)-min(X_Zt));   %realmente esto es lo que tomamos como error 

dif_Z0=Y_Z0-Z0_ajuste; 
errorZ0=mean(dif_Z0);
desv_estZ0=std(dif_Z0)./(max(X_Z0)-min(X_Z0));




%%
%Incertidumbre asociada a la profundidad basal como medida indirecta 
%Zb=2*Z0-Zt;
%errorZb= d/dZ0(Zb)*errorZ0 + d/dZt(Zb)*errorZt

errorZb=2*errorZ0-errorZt;
desv_estZb=2*desv_estZ0-desv_estZt;



%%
%Representacion grafica de los resultados

figure(12)
subplot(2,1,1)
plot(X_Zt,Y_Zt)
hold on
plot(X_Zt,Zt_ajuste);
xlabel('Vector de onda k en el rango del ajuste');
ylabel('ln(\Phi(k)^{1/2}) vs. ajuste')
legend('Valores exactos del espectro','Valores del ajuste')
subplot(2,1,2)
plot(X_Zt,dif_Zt)
xlabel('Vector de onda k en el rango del ajuste')
ylabel('Error en el ajuste')













