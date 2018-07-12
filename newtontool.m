function newtontool(keyword,varargin)

%%%%%%%%%%%%%%%%%%%%%%%%%%  Initialization section.

set(0,'DefaultUIControlFontSize',18);    

if nargin == 0
   
H = findobj(0,'Tag','NEWTONTOOL_figp');
if ~isempty(H)
   warning('symbolic:newtontool:Started','Another NEWTONTOOL is running.  Only 1 NEWTONTOOL can be run at a time.');
   return
end

fstr = 'x^2-4';
xstr = '4';
xarr = { xstr };
fxstr = getvalue(fstr,xstr);
numstr = '1';
xlimstr = '[-5,5]';

% Macros
p = .14*(1:6) - .06;
q = .48 - .14*(1:3);
r = [.14 .10];

% Position the figures and the control panel.
fig1 = figure('name','newtontool : Overview','NumberTitle','off','Units','normalized','Position',[.01 .54 .48 .40],...
              'Menu','none','Tag','fig1');
set(fig1,'CloseRequestFcn','newtontool close');

fig2 = figure('name','newtontool : Newton''s Method','NumberTitle','off','Units','normalized','Position',[.50 .54 .48 .40],...
              'Menu','none','Tag','fig2');
set(fig2,'CloseRequestFcn','newtontool close');

NEWTONTOOL_figp = figure('name','newtontool','NumberTitle','off','Units','normalized','Position',[.25 .10 .48 .40],'Menu','none', ...
              'Tag','NEWTONTOOL_figp',...
              'Color',get(0,'DefaultUIControlBackgroundColor'), ...
              'DefaultUIControlUnit','norm');
set(NEWTONTOOL_figp,'CloseRequestFcn','newtontool close');

% Control panel
figure(NEWTONTOOL_figp);
axes('Parent',NEWTONTOOL_figp,'Visible','off');
uicontrol('Style','frame','Position',[0.01 0.48 0.98 0.50]);
uicontrol('Style','frame','Position',[0.01 0.01 0.98 0.46]);
uicontrol('Style','text','String','f(x)','Position',[0.04 0.85 0.09 0.10]);
uicontrol('Style','text','String','x_n','Position',[0.04 0.73 0.09 0.10],'Tag','xarr','UserData',xarr);
uicontrol('Style','text','String','f(x_n)','Position',[0.54 0.73 0.09 0.10]);
uicontrol('Style','text','String','n','Position',[0.04 0.62 0.09 0.10]);
uicontrol('Style','text','String','xlim','Position',[0.04 0.49 0.09 0.10]);
uicontrol('Position',[.12 .86 .82 .10],'Style','edit', ...
          'HorizontalAlignment','left','BackgroundColor','white', ...
          'String',fstr,'Tag','Sfstr', 'CallBack','newtontool Sfcallback');
uicontrol('Position',[.12 .74 .32 .10],'Style','edit','HorizontalAlignment','left', ...
    'BackgroundColor','white','String',xstr,'Tag','Sxstr','CallBack','newtontool Sxcallback');
uicontrol('Position',[.62 .74 .32 .10],'HorizontalAlignment','left', ...
    'BackgroundColor','white','String',fxstr,'Tag','Sfxstr');
uicontrol('Position',[.12 .62 .32 .10],'HorizontalAlignment','left', ...
    'BackgroundColor','white','String',numstr, 'Tag','Snumstr');
uicontrol('Position',[.12 .50 .32 .10],'Style','edit','HorizontalAlignment','left', ...
    'BackgroundColor','white','String',xlimstr, 'Tag','Sxlimstr',...
    'CallBack','newtontool Sxlimcallback');

% First row operators. 
uicontrol('Position',[p(1) q(1) r],'String','Example 1', ...
   'CallBack','newtontool(''row1'',''ex1'')');
uicontrol('Position',[p(2) q(1) r],'String','Example 2', ...  
   'CallBack','newtontool(''row1'',''ex2'')');
uicontrol('Position',[p(3) q(1) r],'String','Example 3', ...  
   'CallBack','newtontool(''row1'',''ex3'')');
uicontrol('Position',[p(4) q(1) r],'String','Example 4', ...  
   'CallBack','newtontool(''row1'',''ex4'')');
uicontrol('Position',[p(5) q(1) r],'String','Example 5', ...  
   'CallBack','newtontool(''row1'',''ex5'')');
uicontrol('Position',[p(6) q(1) r],'String','Example 6', ...  
   'CallBack','newtontool(''row1'',''ex6'')');

% Second row operators. 
uicontrol('Position',[p(1) q(2) r],'String','Problem 1', ...  
   'CallBack','newtontool(''row2'',''4.8.23'')');
uicontrol('Position',[p(2) q(2) r],'String','Problem 2', ...  
   'CallBack','newtontool(''row2'',''4.8.17'')');

% Third row operators. 
uicontrol('Position',[p(1) q(3) r],'String','n++', ...  
          'CallBack','newtontool nplusplus');
uicontrol('Position',[p(2) q(3) r],'String','n--', ...  
          'CallBack','newtontool nminusminus');
uicontrol('Style','checkbox','Position',[p(5)+.01 q(3) r],'String','Legend', ...
    'CallBack','newtontool legend','Value',1,'Tag','SLegend');
uicontrol('Position',[p(6) q(3) r],'String','Close', ...
    'CallBack','newtontool close');

% plot
newtonplot(NEWTONTOOL_figp,fstr,xstr,fxstr,xlimstr,fig1,fig2);

%%%%%%%%%%%%%%%%%%%%%%%%%%  end of Initialization section

else

    NEWTONTOOL_figp = findobj(0,'Tag','NEWTONTOOL_figp');

switch keyword

%%%%%%%%%%%%%%%%%%%%%%%%%%  Callback for first row of unary operators.
  
case 'row1'
  switch varargin{1}
    case 'ex1'
      fstr = 'x^2-4';
      xstr = '4';
      xarr = { xstr };
      fxstr = getvalue(fstr,xstr);
      numstr = '1';      
      xlimstr = '[-5,5]';
    case 'ex2'
      fstr = '(1/4)*((x+0.4)^4-0.2)';
      xstr = '4';
      xarr = { xstr };
      fxstr = getvalue(fstr,xstr);
      numstr = '1';      
      xlimstr = '[0,5]';
    case 'ex3'
      fstr = 'x^2-4';
      xstr = '-0.05';
      xarr = { xstr };
      fxstr = getvalue(fstr,xstr);
      numstr = '1';      
      xlimstr = '[-5,5]';
    case 'ex4'
      fstr = 'sin(x)';
      xstr = '1.75';
      xarr = { xstr };
      fxstr = getvalue(fstr,xstr);
      numstr = '1';      
      xlimstr = '[0,8]';
    case 'ex5'
      fstr = 'x^3-x-1';
      xstr = '-3';
      xarr = { xstr };
      fxstr = getvalue(fstr,xstr);
      numstr = '1';                  
      xlimstr = '[-3.1,3]';
    case 'ex6'
      fstr = 'sqrt(abs(x))';
      xstr = '0.5';
      xarr = { xstr };
      fxstr = getvalue(fstr,xstr);
      numstr = '1';            
      xlimstr = '[-1,1]';
   end

   fig1 = findobj(0,'Tag','fig1');
   fig2 = findobj(0,'Tag','fig2');  
   if (numel(xstr))
       newtonplot(NEWTONTOOL_figp,fstr,xstr,fxstr,xlimstr,fig1,fig2);
   else
       previewplot(fstr,xlimstr,fig1,fig2);
   end;
   setall(NEWTONTOOL_figp,fstr,xstr,xarr,fxstr,numstr,xlimstr);

%%%%%%%%%%%%%%%%%%%%%%%%%%  Callback for second row of unary operators.
  
case 'row2'
  switch varargin{1}
    case '4.8.23'
      fstr = 'x^6-x^5-6*x^4-x^2+x+10';
      xstr = '';
      xarr = { };
      fxstr = '';
      numstr = '1';                  
      xlimstr = '[-5,5]';
    case '4.8.17'
      fstr = '3*cos(x)-x-1';
      xstr = '';
      xarr = { };      
      fxstr = '';
      numstr = '1';                  
      xlimstr = '[-5,5]';
   end
   
   fig1 = findobj(0,'Tag','fig1');
   fig2 = findobj(0,'Tag','fig2');  
   if (numel(xstr))
       newtonplot(NEWTONTOOL_figp,fstr,xstr,fxstr,xlimstr,fig1,fig2);
   else
       previewplot(fstr,xlimstr,fig1,fig2);
   end;
   setall(NEWTONTOOL_figp,fstr,xstr,xarr,fxstr,numstr,xlimstr);

%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for f's edit text box.
  
  case 'Sfcallback'

    [fstr,xstr,xarr,fxstr,numstr,xlimstr] = getall(NEWTONTOOL_figp);
    xstr = '';
    xarr = { };    
    fxstr = '';
    numstr = '1';
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');      
    previewplot(fstr,xlimstr,fig1,fig2);
    setall(NEWTONTOOL_figp,fstr,xstr,xarr,fxstr,numstr,xlimstr);
    
%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for x's edit text box.
  
  case 'Sxcallback'

    [fstr,xstr,xarr,fxstr,numstr,xlimstr] = ...
        getall(NEWTONTOOL_figp);
    xarr = { xstr };        
    fxstr = getvalue(fstr,xstr);
    numstr = '1';    
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');
    newtonplot(NEWTONTOOL_figp,fstr,xstr,fxstr,xlimstr,fig1,fig2);
    setall(NEWTONTOOL_figp,fstr,xstr,xarr,fxstr,numstr,xlimstr);
    
%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for xlim's edit text box.
  
  case 'Sxlimcallback'

    [fstr,xstr,xarr,fxstr,numstr,xlimstr] = getall(NEWTONTOOL_figp);
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');
    if (numel(xstr))
        newtonplot(NEWTONTOOL_figp,fstr,xstr,fxstr,xlimstr,fig1,fig2);
    else
        previewplot(fstr,xlimstr,fig1,fig2);
    end;
    setall(NEWTONTOOL_figp,fstr,xstr,xarr,fxstr,numstr,xlimstr);
    
%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for nplusplus button.

  case 'nplusplus'

    [fstr,xstr,xarr,fxstr,numstr,xlimstr] = getall(NEWTONTOOL_figp);
    if (numel(xstr))
        xstr = getroot(fstr,xstr);
        xarr{end+1} = xstr;
        fxstr = getvalue(fstr,xstr);
        numval = str2num(numstr);
        numval = numval+1;
        numstr = num2str(numval);
    end;
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');      
    if (numel(xstr))
        newtonplot(NEWTONTOOL_figp,fstr,xstr,fxstr,xlimstr,fig1,fig2);
    else
        previewplot(fstr,xlimstr,fig1,fig2);
    end;
    setall(NEWTONTOOL_figp,fstr,xstr,xarr,fxstr,numstr,xlimstr);

%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for nminusminus button.

  case 'nminusminus'

    [fstr,xstr,xarr,fxstr,numstr,xlimstr] = getall(NEWTONTOOL_figp);
    numval = str2num(numstr);
    if (numval>1)
        xstr = xarr{end-1};
        xarr = xarr(1:end-1);
        fxstr = getvalue(fstr,xstr);
        numval = numval-1;
        numstr = num2str(numval);
    end;
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');      
    if (numel(xstr))
        newtonplot(NEWTONTOOL_figp,fstr,xstr,fxstr,xlimstr,fig1,fig2);
    else
        previewplot(fstr,xlimstr,fig1,fig2);
    end;
    setall(NEWTONTOOL_figp,fstr,xstr,xarr,fxstr,numstr,xlimstr);

%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for Legend button.   
  
  case 'legend'

    [fstr,xstr,xarr,fxstr,numstr,xlimstr] = getall(NEWTONTOOL_figp);    
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');      
    if (numel(xstr))
        newtonplot(NEWTONTOOL_figp,fstr,xstr,fxstr,xlimstr,fig1,fig2);
    else
        previewplot(fstr,xlimstr,fig1,fig2);
    end;
    setall(NEWTONTOOL_figp,fstr,xstr,xarr,fxstr,numstr,xlimstr);
    
%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for Close button.
  
case 'close'
   delete(findobj(0,'Tag','fig1')); 
   delete(findobj(0,'Tag','fig2')); 
   delete(findobj(0,'Tag','NEWTONTOOL_figp')); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end % switch statement for callbacks

end     % end of if statement

function [fstr,xstr,xarr,fxstr,numstr,xlimstr] = getall(newtontool)
  fstr = get(findobj(newtontool,'Tag','Sfstr'),'String');
  xstr = get(findobj(newtontool,'Tag','Sxstr'),'String');
  xarr = get(findobj(newtontool,'Tag','xarr'),'UserData');  
  fxstr = get(findobj(newtontool,'Tag','Sfxstr'),'String');  
  numstr = get(findobj(newtontool,'Tag','Snumstr'),'String');    
  xlimstr = get(findobj(newtontool,'Tag','Sxlimstr'),'String');
  
function setall(newtontool,fstr,xstr,xarr,fxstr,numstr,xlimstr)
  set(findobj(newtontool,'Tag','Sfstr'),'String',fstr);
  set(findobj(newtontool,'Tag','Sxstr'),'String',xstr);
  set(findobj(newtontool,'Tag','xarr'),'UserData',xarr);  
  set(findobj(newtontool,'Tag','Sfxstr'),'String', fxstr);
  set(findobj(newtontool,'Tag','Snumstr'),'String', numstr);  
  set(findobj(newtontool,'Tag','Sxlimstr'),'String',xlimstr);
  
function previewplot(fstr,xlimstr,fig1,fig2)
  syms x;
  fsym = sym(fstr);
  xlimarr = str2num(xlimstr);
  a = xlimarr(1);
  b = xlimarr(2);
  plotn = 200;
  deltaxplot = (b-a)/plotn;
  xvalplot = a+deltaxplot.*[0:plotn];  
  yvalplotf = double(subs(fsym,x,xvalplot));
  maxy = max(yvalplotf);
  miny = min(yvalplotf);
  figure(fig1);
  plot(xvalplot,yvalplotf,'LineWidth',2.0);
  eps = (maxy-miny)*0.1;
  c = miny-eps;
  d = maxy+eps;
  axis([a,b,c,d]);
  hold all;
  plot([a,b],[0,0],'color','black');
  hold off;
  figure(fig2);
  clf;

function newtonplot(newtontool,fstr,xstr,fxstr,xlimstr,fig1,fig2)
  syms x;
  fsym = sym(fstr);
  lsym = getlinear(fstr,xstr);
  root = str2num(getroot(fstr,xstr));
  center = str2num(xstr);
  fcenter = double(subs(fsym,x,center));
  froot = double(subs(fsym,x,root));
  xlimarr = str2num(xlimstr);
  a = xlimarr(1);
  b = xlimarr(2);
  plotn = 200;
  deltaxplot = (b-a)/plotn;
  xvalplot = a+deltaxplot.*[0:plotn];  
  yvalplotf = double(subs(fsym,x,xvalplot));
  maxy = max(yvalplotf);
  miny = min(yvalplotf);
  figure(fig1);
  plot(xvalplot,yvalplotf,'LineWidth',2.0);
  eps = (maxy-miny)*0.1;
  c = miny-eps;
  d = maxy+eps;
  axis([a,b,c,d]);
  ar = (b-a)/(d-c);  
  xmid = (root+center)/2.0;
  miny = min([0,froot,fcenter]);
  maxy = max([0,froot,fcenter]);
  ymid = (miny+maxy)/2.0;
  deltaxval = (abs(root-center)/2.0)*1.1;
  if (deltaxval < 1e-8)
      deltaxval = 1e-8;
  end;
  while (abs(ymid)*1.1 > deltaxval/ar)
      deltaxval = deltaxval*1.1;
  end;
  while (abs(ymid-fcenter)*1.1 > deltaxval/ar)
      deltaxval = deltaxval*1.1;
  end;
  while (abs(ymid-froot)*1.1 > deltaxval/ar)
      deltaxval = deltaxval*1.1;
  end;
  a2 = xmid-deltaxval;
  b2 = xmid+deltaxval;
  c2 = ymid-deltaxval/ar;
  d2 = ymid+deltaxval/ar;
  hold all;
  plot([a,b],[0,0],'color','black');
  h1 = scatter([center],[0],80,'MarkerEdgeColor','black','MarkerFaceColor','black','LineWidth',2.0);
  h2 = scatter([root],[0],80,'MarkerEdgeColor','g','MarkerFaceColor', 'g','LineWidth',2.0);  
  handle = findobj(newtontool,'Tag','SLegend');
  value = get(handle,'Value');
  if value==get(handle,'Max')
      legend([h1 h2], {'\fontsize{18} x_n','\fontsize{18} x_{n+1}'},'Location','NorthWest');
  end;
  hold off;
  plotn2 = 200;
  deltaxplot2 = 2*deltaxval/plotn2;
  xvalplot2 = a2+deltaxplot2.*[0:plotn2];
  yvalplotf2 = double(subs(fsym,x,xvalplot2));
  yvalplotl2 = double(subs(lsym,x,xvalplot2));
  figure(fig2);
  plot(xvalplot2,yvalplotf2,'LineWidth',2.0,'color','blue');
  axis([a2,b2,c2,d2]);
  hold all;
  plot(xvalplot2,yvalplotl2,'LineWidth',2.0,'color','m');
  plot([a2,b2],[0,0],'color','black','LineWidth',1.0);  
  plot([center,center],[0,fcenter],'--','color','black','LineWidth',2.0);
  h1 = scatter([center],[0],80,'MarkerEdgeColor','black','MarkerFaceColor','black','LineWidth',2.0);
  h2 = scatter([root],[0],80,'MarkerEdgeColor','g','MarkerFaceColor', ...
          'g','LineWidth',2.0);  
  handle = findobj(newtontool,'Tag','SLegend');
  value = get(handle,'Value');
  if value==get(handle,'Max')
      legend([h1 h2], {'\fontsize{18} x_n','\fontsize{18} x_{n+1}'},'Location','NorthWest');
  end;
  hold off;

function [fxstr] = getvalue(fstr,xstr)
  syms x;
  fsym = sym(fstr);
  xval = str2num(xstr);
  fxstr = num2str(double(subs(fsym,x,xval)),16);
  
function [lsym] = getlinear(fstr,xstr)
  syms x;
  fsym = sym(fstr);
  center = str2num(xstr);
  fcenter = subs(fsym,x,center);
  fpsym = diff(fsym,x);
  fpcenter = subs(fpsym,x,center);
  lsym = fcenter+fpcenter*(x-center);

function [rootstr] = getroot(fstr,xstr)
  syms x;
  fsym = sym(fstr);
  center = str2num(xstr);
  fcenter = subs(fsym,x,center);
  fpsym = diff(fsym,x);
  fpcenter = subs(fpsym,x,center);
  rootstr = num2str(double(center - fcenter/fpcenter),16);
  