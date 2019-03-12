%% changes response tail for a straight line with a given slope.

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



function mag = dsd_fixtail (F,
                            dB,
                            EndLow,
                            BeginLow,
                            IntervalLow,
                            SlopeLow,
                            EndHigh,
                            BeginHigh,
                            IntervalHigh,
                            SlopeHigh)
        
    
    % frequency jump, F vector length and indexes
    fl = F(2);
    m = length(F);
    K = [1:m]';
    % x difference, octaves log scale
    % added initial 0 for cumsum to be the inversion of diff
    diffKlog2 = diff([0;log2(2*K)]);
    % response curve difference, octaves log scale

    % initializes output response
    mag=dB2mag(dB);
    
    % some checks
    if BeginLow<0
        disp('BeginLow must be positive. Exiting...');
        quit
    end
    if BeginHigh<0
        disp('BeginHigh must be positive. Exiting...');
        quit
    end
    if BeginLow >= BeginHigh && BeginHigh != 0
        disp("\nBeginHigh must be greater than BeginLow. Exiting...\n");
        quit
    end
       

    % low end

    % lower absolute limit
    % it must be positive
    % If cero nothing is done
    if BeginLow != 0

        % get frequency limits
        
       LowF2=BeginLow;
        % transition beginning
        % interval must be positive
        if IntervalLow<0
            disp('IntervalLow must be positive. Exiting...');
            quit
        end
        % if end is 0 or more than beginning use interval
        if EndLow==0 || EndLow>=BeginLow
            LowF1=LowF2/(2^IntervalLow);
        else
            LowF1=EndLow;
        end

        % assign indexes to frequencies
        
        LowK1=round(LowF1/fl)+1;
        LowK2=round(LowF2/fl)+1;
        % avoid cero length transitions
        % and singular situation downwards
        if LowK2<3 LowK2=3; end;
        if LowK1==LowK2 LowK1=LowK2-1; end;

        % work in log space

        diffdBlog2 = diff([0;dB])./diffKlog2;
        % trace straight line with a given slope in dB/oct
        diffdBlinelog = ones(m,1)*SlopeLow;
        % transition mask (column vectors)
        trans = [ones(LowK1-1,1); ...
                linspace(1,0,LowK2-LowK1+1)'; ...
                zeros(m-LowK2,1)];
        diffdBlog2 = diffdBlog2.*(1-trans)+diffdBlinelog.*trans;
        % value at the beginning of transition
        begindB=dB(LowK2);

        % back to linear space

        % convert to linear space and integrate
        dB=cumsum(diffdBlog2.*diffKlog2);
        % uplevel to join at EQ beginning
        dB=dB-dB(LowK2)+begindB;
        mag=dB2mag(dB);
    end

    % high end

    % upper absolute limit
    % it must be positive
    % If cero nothing is done
    if BeginHigh != 0

        % get frequency limits
        
        % if too high use the last bin.
        if BeginHigh>F(end)
            HighF1=F(end);
        else
            HighF1=BeginHigh;
        end
        % transition beginning
        % interval must be positive
        if IntervalHigh<0
            disp('IntervalHigh must be positive. Exiting...');
            quit
        end
        % if end is 0 or less than beginning use interval
        if EndHigh==0 || EndHigh<=BeginHigh
            HighF2=HighF1*(2^IntervalHigh);
        else
            HighF2=EndHigh;
        end

        % assign indexes to frequencies
        
        HighK1=round(HighF1/fl)+1;
        HighK2=round(HighF2/fl)+1;
        % avoid cero length transitions
        % and singular situation downwards
        if HighK1>m-2 HighK1=m-2; end;
        if HighK2<=HighK1 HighK2=HighK1+1; end;
        if HighK2>m HighK2=m-1; end;


        % work in log space
        
        diffdBlog2 = diff([0;dB])./diffKlog2;
        % trace straight line with a given slope in dB/oct
        diffdBlinelog = ones(m,1)*SlopeHigh;
        % transition mask (column vectors)
        trans = [zeros(HighK1-1,1); ...
                linspace(0,1,HighK2-HighK1+1)'; ...
                ones(m-HighK2,1)];
        diffdBlog2 = diffdBlog2.*(1-trans)+diffdBlinelog.*trans;
        % value at the beginning of transition
        begindB=dB(HighK1);

        % back to linear space

        % convert to linear space and integrate
        dB=cumsum(diffdBlog2.*diffKlog2);
        % uplevel to join at EQ beginning
        dB=dB-dB(HighK1)+begindB;
        mag=dB2mag(dB);
    end

endfunction

