function [param] = getAllFigureProperties()
%GETALLFIGUREPROPERTIES Summary of this function goes here
%   Detailed explanation goes here
	figHandles	= get(groot, 'Children');
	nfigures	= length(figHandles);
	
	param.nfig	= nfigures;
	for i = 1 : nfigures
		fh_idx			= nfigures - (i - 1);
		fh				= figHandles(fh_idx);
		allAxesInFigure = flip(findall(fh,'type','axes'));
		naxs			= length(allAxesInFigure);
		
		param.fig(i).name			= get(fh, 'name');
		param.fig(i).nsubplot		= naxs;
		
		for j  = 1:naxs
			ca							= allAxesInFigure(j);

			title_field					= get(ca,'title');
			xlabel_field				= get(ca,'xlabel');
			ylabel_field				= get(ca,'ylabel');
			
			
			
			param.fig(i).axes(j).handle = ca;
			param.fig(i).axes(j).title	= getFieldParams(title_field);
			param.fig(i).axes(j).xlabel = getFieldParams(xlabel_field);
			param.fig(i).axes(j).ylabel = getFieldParams(ylabel_field);
			
		end
	end
end

function param = getFieldParams(field)

	param.string		= string(get(field,'string'));
	param.interpreter	= string(get(field,'interpreter'));
	param.fontsize		= get(field,'fontsize');
end

