%% usage logf = logfreq(m,fs,ppo)
%%
%% Genera un vector de frecuencias espaciado logaritmicamente,
%% entre el bin menor no nulo del fft y fs/2.
%%
%% m   = Longitud del fft original.
%% fs  = Frecuencia de muestreo.
%% ppo = Fracción de octava del intervalo de frecuencias.

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

function logf=logfreq(m,fs,ppo);

    f2 = fs/2;
    f1 = fs/m;
    jump = 2^(1/ppo);
    steps = log(f2/f1)/log(jump);
    top = ceil(steps);
    logf = ((1:top)')+(top-steps-1/2); % vector columna
    logf = f1*(jump.^logf);

end
