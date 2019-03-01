%% usage: imp=crossButterworthLP(fs,m,nl,fl,nh,fh)
%%
%% Obtiene el filtro FIR de fase lineal con la magnitud
%% de un filtro butterworth de orden n.
%%
%% imp = Coeficientes del filtro FIR.
%% Fs = Frecuencia de muestreo.
%% m = Número de muestras.
%% nl = Orden del filtro pasaaltos.
%% fl = Frecuencia de corte inferior (pasaaltos). 0 para pasabajos.
%% nh = Orden del filtro pasabajos.
%% fh = Frecuencia de corte superior (pasabajos). 0 para pasaaltos.

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

function imp=crossButterworthLP(fs,m,nl,fl,nh,fh);
    
    wl=fl/(fs/2);
    wh=fh/(fs/2);
    % low freq, freq jump
    mLow = fs/m;
    % indexes of non aliased frequency vector
    ssK = 0:m/2;
    % non aliased frequency vector
    ssF = mLow*(ssK);

    % Lowpass
    if (fl==0) && (fh>0)
        [b,a]=butter(nh,wh);
        mag = abs(freqz(b,a,ssF,fs));
    % Highpass
    elseif (fl>0) && (fh==0)
        [b,a]=butter(nl,wl,'high');
        mag = abs(freqz(b,a,ssF,fs));
    % Bandpass
    elseif (fl>0) && (fh>0)
        [b,a]=butter(nh,wh);
        magh = abs(freqz(b,a,ssF,fs));
        [b,a]=butter(nl,wl,'high');
        magl = abs(freqz(b,a,ssF,fs));
        mag=magh.*magl;
    % Delta
    elseif (fl==0) && (fh==0)
        imp=centerimp(deltacentered(m-1),m);
        return;
    end
    
    % mag = freqz(b,a,ssF,fs);
    imp = circshift(real(ifft(wholesplp(mag'))),m/2);
    imp = blackmanharris (m) .* imp;
end
