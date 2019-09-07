
function SimOpt = plotParameterSpace()

SimOpt{1} = generate_sim_ann_options('all');

SimOpt{2} = generate_sim_ann_options('young');
SimOpt{3} = generate_sim_ann_options('old');

SimOpt{4} = generate_sim_ann_options('group1of2');
SimOpt{5} = generate_sim_ann_options('group2of2');

SimOpt{6} = generate_sim_ann_options('group1of2_2');
SimOpt{7} = generate_sim_ann_options('group2of2_2');

SimOpt{8} = generate_sim_ann_options('group1of3');
SimOpt{9} = generate_sim_ann_options('group2of3');
SimOpt{10} = generate_sim_ann_options('group3of3');

figure; hold on;
dx = 0.01; dy = 0.01; % displacement so the text does not overlay the data points
 
for nn = 1:length(SimOpt)
    
    eps_str = (SimOpt{nn}.sim_values{end-1});
    eps_pfc = (SimOpt{nn}.sim_values{end});
    scatter(eps_str, eps_pfc, 1e5*(1./SimOpt{nn}.BIC^2), 'filled');
    text(eps_str+dx, eps_pfc+dy, SimOpt{nn}.name);

end

xlabel('\epsilon_{str}');
ylabel('\epsilon_{ctx}');

end