% This function produces a discrepancy function with
% with a penaliser that increases esponentially 
% usage example: 
% discrepancy_with_penaliser('lin',performances.P1,4.7802,6.5714,8.3626)
% discrepancy_with_penaliser('log',performances.P3,0.6212,4.2979,7.9746)

function discrepancy_value = discrepancy_with_penaliser(type,baseline_value,varargin)
% Rename extreme and central (b) values
a = varargin{1};
b = varargin{2};
c = varargin{3};
x = baseline_value;

% coefficients for the functions
k = 1/(b-a);
z = k*a;

% Calculate discrepancy values
switch  type
    case 'log'
        if x < a || x > c
            discrepancy_value = +100;
        elseif x >= a && x <= b
            discrepancy_value = -log(k*x-z);  
        elseif x > b && x <= c
            discrepancy_value = -log(k*(2*b-x)-z);
        end
    case 'lin'
        if x < a || x > c
            discrepancy_value = abs(b-x);
        else 
            discrepancy_value =  abs(b-x);
        end
end

end