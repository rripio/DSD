%% usage: [mag, pha] = HouseCurve (F, f_corner, house_atten, fs)
%%
%% Obtiene los valores de la ecualización House Curve sobre un
%% vector de frecuencias f.
%%
%% mag         = Vector de magnitudes (dB).
%% pha         = Vector de fases (deg).
%% F           = Vector de frecuencias.
%% f_corner    = Frecuencia en la que empieza a bajar la curva.
%% house_atten = Atenuación a 20kHz.
%% fs          = Frecuencia de muestreo.

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

function [mag, pha] = HouseCurve (F, f_corner, house_atten, fs);

    if ! iscolumn(F)
        error ("F must be a column vector")
    end
    
    m_exp = 16;
    m = 2^m_exp; % parece precisión suficiente
    f = (0:m/2)' * fs/m; % f bins semi
    
    if (nargin < 3)
        error ("nargin < 3");
    end

    % Corner rounding interval in octaves
    round_interval = 1;
    % Scale factor for circular corner bending
    scale_factor = 10;
    % Reference frequency for house curve attenuation
    f_max = 20000;
    house_atten = house_atten / scale_factor;
    
    f_log = log(f);
    f_corner_log = log(f_corner);
    f_max_log = log(f_max);
    f1_log = log(f_corner / 2^round_interval);
    f1_dist = f_corner_log - f1_log;
    ang = atan(house_atten / (f_max_log - f_corner_log));
    f2_log = f_corner_log + (f1_dist * cos(ang));
    y_center = -(f1_dist / tan(ang/2));
    x_center = f1_log;
    
    range_1 = f_log(find(f_log < f1_log));
    range_2 = f_log(find(f_log >= f1_log & f_log < f2_log));
    range_3 = f_log(find(f_log >= f2_log));

    resp_1 = zeros(size(range_1));
    resp_2 = sqrt((y_center^2) - ((range_2 - x_center).^2)) + y_center;
    resp_3 = -tan(ang) * (range_3 - f_corner_log);
    
    smag = scale_factor * [resp_1; resp_2; resp_3]; % Respuesta en dB
    spha = arg(semisp(minphsp(wholespmp (dB2mag(smag))))) * 180/pi;
    
    mag = spline (f, smag, F);
    pha = spline (f, spha, F);

endfunction
