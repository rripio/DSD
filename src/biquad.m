%% usage: [b,a] = biquad(fs,f0,Q,type,dBgain)
%%
%% Obtiene los coeficientes del filtro IIR asociado a un biquad.
%%
%% [b,a] = Coeficientes del filtro IIR.
%% fs    = Frecuencia de muestreo.
%% f0    = Frecuencia central del filtro.
%% Q     = Definido en "DSP EQ cookbook".
%%         En "peakingEQ" el ancho de banda es
%%         entre puntos de ganancia mitad.
%% type  = Valor de cadena entre:
%%         LPF, HPF, notch, peakingEQ, lowShelf o highShelf.
%% dBgain = Solo para peakingEQ, lowShelf o highShelf.

%% This file is part of DSD
%%
%% DSD
%% A GNU-Octave set of scripts for calculating
%% digital loudspeaker crossovers and room correction filters
%% Copyright (C) 2012-2019 Roberto Ripio
%%
%% DSD is free software: you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation, either version 3 of the License, or
%% (at your option) any later version.
%%
%% DSD is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License
%% along with DSD.  If not, see <https://www.gnu.org/licenses/>.

function [b,a]=biquad(fs,f0,Q,type,dBgain);
    
    if (nargin < 4)
        error ("nargin < 4");
    end
    if (Q <= 0)
        error ("Q must be positive");
    end
    if (f0 <= 0) || (fs <= 0)
        error ("f must be positive");
    end
    

    w0 = 2*pi*f0/fs;
    alpha = sin(w0)/(2*Q);
    
    switch (type)
        case "LPF"
            b0 =  (1 - cos(w0))/2;
            b1 =   1 - cos(w0);
            b2 =  (1 - cos(w0))/2;
            a0 =   1 + alpha;
            a1 =  -2*cos(w0);
            a2 =   1 - alpha;
        case "HPF"
            b0 =  (1 + cos(w0))/2;
            b1 = -(1 + cos(w0));
            b2 =  (1 + cos(w0))/2;
            a0 =   1 + alpha;
            a1 =  -2*cos(w0);
            a2 =   1 - alpha;
        case "notch"
            b0 =   1;
            b1 =  -2*cos(w0);
            b2 =   1;
            a0 =   1 + alpha;
            a1 =  -2*cos(w0);
            a2 =   1 - alpha;
        case "peakingEQ"
            A  = 10^(dBgain/40);
            
            b0 =   1 + alpha*A;
            b1 =  -2*cos(w0);
            b2 =   1 - alpha*A;
            a0 =   1 + alpha/A;
            a1 =  -2*cos(w0);
            a2 =   1 - alpha/A;
        case "lowShelf"
            A  = 10^(dBgain/40);
            
            b0 =    A*( (A+1) - (A-1)*cos(w0) + 2*sqrt(A)*alpha );
            b1 =  2*A*( (A-1) - (A+1)*cos(w0)                   );
            b2 =    A*( (A+1) - (A-1)*cos(w0) - 2*sqrt(A)*alpha );
            a0 =        (A+1) + (A-1)*cos(w0) + 2*sqrt(A)*alpha;
            a1 =   -2*( (A-1) + (A+1)*cos(w0)                   );
            a2 =        (A+1) + (A-1)*cos(w0) - 2*sqrt(A)*alpha;
        case "highShelf"
            A  = 10^(dBgain/40);
            
            b0 =    A*( (A+1) + (A-1)*cos(w0) + 2*sqrt(A)*alpha );
            b1 = -2*A*( (A-1) + (A+1)*cos(w0)                   );
            b2 =    A*( (A+1) + (A-1)*cos(w0) - 2*sqrt(A)*alpha );
            a0 =        (A+1) - (A-1)*cos(w0) + 2*sqrt(A)*alpha;
            a1 =    2*( (A-1) - (A+1)*cos(w0)                   );
            a2 =        (A+1) - (A-1)*cos(w0) - 2*sqrt(A)*alpha;
        otherwise
            error ("Wrong biquad type");
    end
    
    a = [a0 a1 a2];
    b = [b0 b1 b2];
end
