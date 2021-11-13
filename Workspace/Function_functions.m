% fzero('cos',[0 pi])
% fzero('exp(x)-2',[0 1])
% x = eval('sin(pi/4)')
% 
% y = 1;
% str = ['exp(' num2str(y) ') –1'];
% res = eval(str)


% Check the second argument to see if it has two
% elements. Note that this double test allows the
% argument to be either a row or a column vector.
if ( size(xlim,1) == 1 && size(xlim,2) == 2 ) || ...
    ( size(xlim,1) == 2 && size(xlim,2) == 1 )
    % Ok--continue processing.
    n_steps = 100;
    step_size = (xlim(2) - xlim(1)) / n_steps;
    x = xlim(1):step_size:xlim(2);
    y = feval(fun,x);
    plot(x,y);
    title(['\bfPlot of function ' fun '(x)']);
    xlabel('\bfx');
    ylabel(['\bf' fun '(x)']);
else
    % Else wrong number of elements in xlim.
    error('Incorrect number of elements in xlim.');
end



