%% Copyright (C) 2012 Roberto Ripio
%%
%% This program is free software; you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation; either version 2 of the License, or
%% (at your option) any later version.
%%
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License
%% along with this program; if not, write to the Free Software
%% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
%%
%% This function is part of DSD

%% usage: xs = smooth (xws,ppo)
%%
%% Suaviza un semiespectro real con un ancho dado en fracci�n de octava.
%%
%% xsss = vector columna con el semiespectro suavizado.
%% xws = vector columna de valores reales (magnitud o fase) del	semiespectro.
%% ppo = fracci�n de octava del suavizado.

function xsss=smooth(xws,ppo);

	if ! iscolumn(xws)
		error ("xws must be a column vector")
	end

	d=length(xws); n2=d-1; n=n2*2;
	f=(0:n2)';  					% frecuencias normalizadas
	l=zeros(d,2);                   % L�mites de integraci�n
	kl=zeros(d,2);               	% �ndices de los l�mites de integraci�n.
	fl=zeros(d,2);				    % Fracci�n del siguiente bin
	
	step=2^(0.5/ppo);

	l(:,1) =f/step; l(:,2) =f*step;

	temp=ceil(l(:,1)+0.5);
	kl(:,1)=temp+1; % Sumar uno pasa de frecuencia a �ndice
	fl(:,1)=temp-(l(:,1)+0.5);
	
	l(l>n2)=n2;
	temp=floor(l(:,2)-0.5);
	kl(:,2)=temp+1; % Sumar uno pasa de frecuencia a �ndice
	fl(:,2)=l(:,2)-0.5-temp;%%%%%%%%%%%%%
	
	
	xsss=zeros(d,1);
	
	for i=2:d;
	    % Suma por la izquierda
	    if kl(i,1)<i;
            xsss(i)+=sum(xws(kl(i,1):i-1))\
            + fl(i,1)*xws(kl(i-1,1))\
            + 0.5*xws(i);
        elseif kl(i,1)==i;
            xsss(i)+=fl(i,1)*xws(i-1)\
            + 0.5*xws(i);
        else
            fl(i,1)-=0.5;
            xsss(i)+=fl(i,1)*xws(i);
        end
        % Suma por la derecha
        if kl(i,2)>i;
            xsss(i)+=sum(xws(i+1:kl(i,2)))\
            + fl(i,2)*xws(kl(i+1,2))\
            + 0.5*xws(i);
        elseif kl(i,2)==i;
            xsss(i)+=fl(i,2)*xws(i+1)\
            + 0.5*xws(i);
        else
            fl(i,2)-=0.5;
            xsss(i)+=fl(i,2)*xws(i);
        end
        
        xsss(i)/=(l(i,2)-l(i,1));
%        xsss(i)/=f(i)-l(i,1);
%        xsss(i)/=-f(i)+l(i,2);
	end
	xsss(1)=xws(1);
	
end