function rsumtool(keyword,varargin)
    
%%%%%%%%%%%%%%%%%%%%%%%%%%  Initialization section.

set(0,'DefaultUIControlFontSize',18);        
    
if nargin == 0
   
H = findobj(0,'Tag','RSUMTOOL_figp');
if ~isempty(H)
   warning('symbolic:rsumtool:Started','Another RSUMTOOL is running.  Only 1 RSUMTOOL can be run at a time.');
   figure(H);
   Fhand = findobj(0,'Tag','figf');
   Ghand = findobj(0,'Tag','figg');
   figure(Fhand); figure(Ghand);
   return
end

fstr = 'exp(x^2)';
xstr = '[0,3/2]';
nstr = '8';
[leftstr, rightstr, diffstr] = getsum(fstr,xstr,nstr);

% Macros
p = .14*(1:6) - .06;
q = .48 - .14*(1:3);
r = [.14 .10];

% Position the two figures and the control panel.
figf = figure('name','Left Riemann Sum','NumberTitle','off','Units','normalized','Position',[.01 .54 .48 .40],...
              'Menu','none','Tag','figf');
set(figf,'CloseRequestFcn','rsumtool close');
figg = figure('name','Right Riemann Sum','NumberTitle','off','Units','normalized','Position',[.50 .54 .48 .40],...
              'Menu','none', 'Tag','figg');
set(figg,'CloseRequestFcn','rsumtool close');
RSUMTOOL_figp = figure('name','rsumtool','NumberTitle','off','Units','normalized','Position',[.25 .10 .48 .40],'Menu','none', ...
              'Tag','RSUMTOOL_figp',...
              'Color',get(0,'DefaultUIControlBackgroundColor'), ...
              'DefaultUIControlUnit','norm');
set(RSUMTOOL_figp,'CloseRequestFcn','rsumtool close');

rsumplot(fstr,xstr,nstr);

% Control panel
figure(RSUMTOOL_figp);
axes('Parent',RSUMTOOL_figp,'Visible','off');
uicontrol('Style','frame','Position',[0.01 0.48 0.98 0.50]);
uicontrol('Style','frame','Position',[0.01 0.01 0.98 0.46]);
uicontrol('Style','text','String','f(x)','Position',[0.04 0.85 0.09 0.10]);
uicontrol('Style','text','String','[a,b]','Position',[0.04 0.73 0.09 0.10]);
uicontrol('Style','text','String','n','Position',[0.54 0.73 0.09 0.10]);
uicontrol('Style','text','String','Left Sum','Position',[0.04 0.61 0.09 0.10]);
uicontrol('Style','text','String','Right Sum','Position',[0.54 0.61 0.09 0.10]);
uicontrol('Style','text','String','| L - R |','Position',[0.02 0.485 0.09 0.10]);
uicontrol('Position',[.12 .86 .82 .10],'Style','edit','HorizontalAlignment','left','BackgroundColor','white','String', fstr,'Tag','Sfstr','CallBack','rsumtool Sfcallback');
uicontrol('Position',[.12 .74 .32 .10],'Style','edit','HorizontalAlignment','left','BackgroundColor','white','String',xstr, 'Tag','Sxstr','CallBack','rsumtool Sxcallback');
uicontrol('Position',[.62 .74 .32 .10],'Style','edit','HorizontalAlignment','left','BackgroundColor','white','String',nstr, 'Tag','Snstr','CallBack','rsumtool Sncallback');
uicontrol('Position',[.12 .62 .32 .10],'HorizontalAlignment','left','BackgroundColor','white','String',leftstr, 'Tag','Sleftstr');
uicontrol('Position',[.62 .62 .32 .10],'HorizontalAlignment','left','BackgroundColor','white','String',rightstr, 'Tag','Srightstr');
uicontrol('Position',[.12 .50 .32 .10],'HorizontalAlignment','left','BackgroundColor','white','String',diffstr, 'Tag','Sdiffstr');

% First row operators. 
uicontrol('Position',[p(1) q(1) r],'String','Example1', ...  
   'CallBack','rsumtool(''row1'',''example1'')');
uicontrol('Position',[p(2) q(1) r],'String','Example2', ...
   'CallBack','rsumtool(''row1'',''example2'')');
uicontrol('Position',[p(3) q(1) r],'String','Example3', ...  
   'CallBack','rsumtool(''row1'',''example3'')');

% Second row operators. 
uicontrol('Position',[p(1) q(2) r],'String','Double n', ...
    'CallBack','rsumtool doublen');
uicontrol('Position',[p(2) q(2) r],'String','n=8', ...
    'CallBack','rsumtool nequal8');

% Third row, auxiliary controls.
uicontrol('Position',[p(6) q(3) r],'String','Close', ...
    'CallBack','rsumtool close');

%%%%%%%%%%%%%%%%%%%%%%%%%%  end of Initialization section

else
    RSUMTOOL_figp = gcbf;
    if isempty(RSUMTOOL_figp)
        RSUMTOOL_figp = findobj(0,'Tag','RSUMTOOL_figp');
    end
switch keyword

%%%%%%%%%%%%%%%%%%%%%%%%%%  Callback for top row of unary operators.
  
  case 'row1'

    switch varargin{1}
      case 'example1'
        fstr = 'exp(x^2)';
        xstr = '[0,3/2]';
        nstr = '8';
      case 'example2'
        fstr = 'cos(x^2)';
        xstr = '[0,2]';
        nstr = '8';
      case 'example3'
        fstr = 'sqrt(abs(x^2-5*x+6))';
        xstr = '[0,4]';
        nstr = '8';
    end
    
    rsumplot(fstr,xstr,nstr);
    [leftstr, rightstr, diffstr] = getsum(fstr,xstr,nstr); 
    setall(RSUMTOOL_figp,fstr,xstr,nstr,leftstr,rightstr,diffstr);
    
%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for f's edit text box.
  
  case 'Sfcallback'

    [fstr,xstr,nstr,leftstr,rightstr,diffstr] = getall(RSUMTOOL_figp);
    rsumplot(fstr,xstr,nstr);
    [leftstr, rightstr, diffstr] = getsum(fstr,xstr,nstr); 
    setall(RSUMTOOL_figp,fstr,xstr,nstr,leftstr,rightstr,diffstr);
   
%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for x's edit text box.
  
  case 'Sxcallback'

    [fstr,xstr,nstr,leftstr,rightstr,diffstr] = getall(RSUMTOOL_figp);
    rsumplot(fstr,xstr,nstr);
    [leftstr, rightstr, diffstr] = getsum(fstr,xstr,nstr); 
    setall(RSUMTOOL_figp,fstr,xstr,nstr,leftstr,rightstr,diffstr);
    
%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for n's edit text box.
  
  case 'Sncallback'

    [fstr,xstr,nstr,leftstr,rightstr,diffstr] = getall(RSUMTOOL_figp);
    rsumplot(fstr,xstr,nstr);
    [leftstr, rightstr, diffstr] = getsum(fstr,xstr,nstr); 
    setall(RSUMTOOL_figp,fstr,xstr,nstr,leftstr,rightstr,diffstr);

%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for Double n button. 

  case 'doublen'

    [fstr,xstr,nstr,leftstr,rightstr,diffstr] = getall(RSUMTOOL_figp);    
    nval = str2num(nstr);
    nval = nval*2;
    nstr = num2str(nval);
    rsumplot(fstr,xstr,nstr);
    [leftstr, rightstr, diffstr] = getsum(fstr,xstr,nstr); 
    setall(RSUMTOOL_figp,fstr,xstr,nstr,leftstr,rightstr,diffstr);
    
%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for n=8 button. 

  case 'nequal8'

    [fstr,xstr,nstr,leftstr,rightstr,diffstr] = getall(RSUMTOOL_figp);    
    nstr = '8';
    rsumplot(fstr,xstr,nstr);
    [leftstr, rightstr, diffstr] = getsum(fstr,xstr,nstr); 
    setall(RSUMTOOL_figp,fstr,xstr,nstr,leftstr,rightstr,diffstr);

%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for Close button.
  
  case 'close'

    delete(findobj(0,'Tag','figf')); 
    delete(findobj(0,'Tag','figg')); 
    delete(findobj(0,'Tag','RSUMTOOL_figp')); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end % switch statement for callbacks

end     % end of if statement

function [fstr,xstr,nstr,leftstr,rightstr,diffstr] = getall(rsumtool)
  fstr = get(findobj(rsumtool,'Tag','Sfstr'),'String');
  xstr = get(findobj(rsumtool,'Tag','Sxstr'),'String');
  nstr = get(findobj(rsumtool,'Tag','Snstr'),'String');
  leftstr = get(findobj(rsumtool,'Tag','Sleftstr'),'String');
  rightstr = get(findobj(rsumtool,'Tag','Srightstr'),'String');
  diffstr = get(findobj(rsumtool,'Tag','Sdiffstr'),'String');
  
function setall(rsumtool,fstr,xstr,nstr,leftstr,rightstr,diffstr)
   set(findobj(rsumtool,'Tag','Sfstr'),'String',fstr);
   set(findobj(rsumtool,'Tag','Sxstr'),'String',xstr);
   set(findobj(rsumtool,'Tag','Snstr'),'String',nstr);
   set(findobj(rsumtool,'Tag','Sleftstr'),'String',leftstr);
   set(findobj(rsumtool,'Tag','Srightstr'),'String',rightstr);
   set(findobj(rsumtool,'Tag','Sdiffstr'),'String',diffstr);
    
function [leftstr, rightstr, diffstr] = getsum(fstr,xlimstr,nstr)
  syms x;
  fsym = sym(fstr);
  xlimarr = str2num(xlimstr);
  a = xlimarr(1);
  b = xlimarr(2);
  n = str2num(nstr);
  deltax = (b-a)/n;
  leftpts = a+deltax.*[0:n-1];
  rightpts = a+deltax.*[1:n];
  leftf = double(subs(fsym,x,leftpts));
  rightf = double(subs(fsym,x,rightpts)); 
  left = deltax*sum(leftf);
  right = deltax*sum(rightf); 
  leftstr = num2str(left,8);
  rightstr = num2str(right,8);
  diff = abs(left-right);
  diffstr = num2str(diff,8);
    
function rsumplot(fstr,xlimstr,nstr)
  figf = findobj(0,'Tag','figf');
  figg = findobj(0,'Tag','figg');
  syms x;
  fsym = sym(fstr);
  plotn = 200;
  xlimarr = str2num(xlimstr);
  a = xlimarr(1);
  b = xlimarr(2);
  n = str2num(nstr);
  deltax = (b-a)/n;
  deltaxplot = (b-a)/plotn;
  xval = a+deltax.*[0:n];
  xvalplot = a+deltaxplot.*[0:plotn];
  yval = double(subs(fsym,x,xval));
  yvalplot = double(subs(fsym,x,xvalplot));
  linexval1 = reshape ([xval;xval;xval],1,[]);
  linexval = [linexval1,[a]];
  yval1left = [[0],yval(1:end-1)];
  yval1right = [[0],yval(2:end)];
  yval2 = zeros(1,n+1);
  yval3left = [yval(1:end-1),[0]];
  yval3right = [yval(2:end),[0]];
  lineyvalleft1 = reshape ([yval1left;yval2;yval3left],1,[]);
  lineyvalleft = [lineyvalleft1,[0]];
  lineyvalright1 = reshape ([yval1right;yval2;yval3right],1,[]);
  lineyvalright = [lineyvalright1,[0]];
  maxy = max(yvalplot);
  miny = min(yvalplot);
  eps = (maxy-miny)*0.1;
  figure(figf);
  plot(linexval,lineyvalleft,'LineWidth',2.0);
  axis([a,b,miny-eps,maxy+eps]);
  title('')  
  hold all;
  plot(xvalplot,yvalplot,'color','red','LineWidth',2.0);
  hold off;
  figure(figg);
  plot(linexval,lineyvalright,'LineWidth',2.0);
  axis([a,b,miny-eps,maxy+eps]);
  title('')  
  hold all;
  plot(xvalplot,yvalplot,'color','red','LineWidth',2.0);
  hold off;
