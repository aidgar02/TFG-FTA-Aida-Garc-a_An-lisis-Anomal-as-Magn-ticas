%Retículos
%Para la obtención del mapa 2D de la profundidad de Curie


n2=input('Número de retículos verticales n2=');      %numero de retículos verticales
n1=2*n2;                                             %numero de reticulos horizontales
Zb_=ones(n2,n1);
h1=(83-77)/n1;   
h2=(14-11)/n2;     %pasos 

 

for r=1:n1
    for s=1:n2
        x=linspace(-83+(s-1)*h1,-83+s*h1, length(LON)*0.01);
        y=linspace(14-h2*r,14-(r-1)*h2,length(LAT)*0.01);
        [X,Y]=meshgrid(x,y);
        F=scatteredInterpolant(LON,LAT,MAG_RES,'natural');
        Z=F(X,Y);
        [k,l,P]=promrad(Z,4.8);
        run ajustezt_z0
        Zb_(s,r)=Zb;
    end
end

figure(11)
contour(Zb_)


