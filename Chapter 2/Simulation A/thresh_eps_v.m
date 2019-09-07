function y = thresh_eps_v(activation, epsilon, gradient)

%% Apply the slope function (as a vector)
for ii = 1:length(activation) 
    
    if activation(ii) >= 1/gradient + epsilon 
        y(ii) = 1; 
    elseif activation(ii) < epsilon 
        y(ii) = 0;
    else
        y(ii) = gradient * (activation(ii) - epsilon);
    end

end
end