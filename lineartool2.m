function lineartool2(keyword,varargin)

%%%%%%%%%%%%%%%%%%%%%%%%%%  Initialization section.

set(0,'DefaultUIControlFontSize',18);    

if nargin == 0
   
H = findobj(0,'Tag','LINEARTOOL2_figp');
if ~isempty(H)
   warning('symbolic:lineartool2:Started','Another LINEARTOOL2 is running.  Only 1 LINEARTOOL2 can be run at a time.');
   return
end

fstr = 'sin(x)';
astr = '0';
lstr = getlinear(fstr,astr);
deltastr = '0.5';
xlimstr = '[-pi,pi]';
epsilonstr = '0.1';

% Macros
p = .14*(1:6) - .06;
q = .48 - .14*(1:3);
r = [.14 .10];

% Position the figures and the control panel.
fig1 = figure('name','lineartool2 : Overview','NumberTitle','off','Units','normalized','Position',[.01 .54 .48 .40],...
              'Menu','none','Tag','fig1');
set(fig1,'CloseRequestFcn','lineartool2 close');

fig2 = figure('name','lineartool2 : Zoom','NumberTitle','off', ...
              'Units','normalized','Position',[.50 .54 .48 .40],...
              'Menu','none','Tag','fig2');
set(fig2,'CloseRequestFcn','lineartool2 close');

fig3 = figure('name','lineartool2 : Size of Second Derivative','NumberTitle','off', ...
              'Units','normalized','Position', [.01 .10 .48 .40],...
              'Menu','none','Tag','fig3');
set(fig3,'CloseRequestFcn','lineartool2 close');

LINEARTOOL2_figp = figure('name','lineartool2','NumberTitle','off','Units','normalized','Position',[.50 .10 .48 .40],'Menu','none', ...
              'Tag','LINEARTOOL2_figp',...
              'Color',get(0,'DefaultUIControlBackgroundColor'), ...
              'DefaultUIControlUnit','norm');

set(LINEARTOOL2_figp,'CloseRequestFcn','lineartool2 close');

% Control panel
figure(LINEARTOOL2_figp);
axes('Parent',LINEARTOOL2_figp,'Visible','off');
uicontrol('Style','frame','Position',[0.01 0.48 0.98 0.50]);
uicontrol('Style','frame','Position',[0.01 0.01 0.98 0.46]);
uicontrol('Style','text','String','f(x)','Position',[0.04 0.86 0.09 0.10]);
uicontrol('Style','text','String','L(x)','Position',[0.04 0.74 0.09 0.10]);
uicontrol('Style','text','String','a','Position',[0.04 0.62 0.09 ...
                    0.10]);
uicontrol('Style','text','String','delta','Position',[0.52 0.62 0.09 0.10]);
uicontrol('Style','text','String','xlim','Position',[0.04 0.50 0.09 0.10]);
uicontrol('Style','text','String','epsilon','Position',[0.52 0.50 0.09 0.10]);
uicontrol('Position',[.12 .86 .82 .10],'Style','edit', ...
          'HorizontalAlignment','left','BackgroundColor','white', ...
          'String',fstr,'Tag','Sfstr', 'CallBack','lineartool2 Sfcallback');
uicontrol('Position',[.12 .74 .82 .10],'HorizontalAlignment','left', ...
    'BackgroundColor','white', ...
    'String',lstr,'Tag','Slstr');
uicontrol('Position',[.12 .62 .32 .10],'Style','edit','HorizontalAlignment','left', ...
    'BackgroundColor','white','String',astr,'Tag','Sastr','CallBack','lineartool2 Sacallback');
uicontrol('Position',[.62 .62 .32 .10],'Style','edit','HorizontalAlignment','left', ...
    'BackgroundColor','white','String',deltastr,'Tag','Sdeltastr','CallBack','lineartool2 Sdeltacallback');
uicontrol('Position',[.12 .50 .32 .10],'Style','edit','HorizontalAlignment','left', ...
    'BackgroundColor','white','String',xlimstr, 'Tag','Sxlimstr',...
    'CallBack','lineartool2 Sxlimcallback');
uicontrol('Position',[.62 .50 .32 .10],'Style','edit','HorizontalAlignment','left', ...
    'BackgroundColor','white','String',epsilonstr, 'Tag','Sepsilonstr',...
    'CallBack','lineartool2 Sepsiloncallback');

% First row operators. 
uicontrol('Position',[p(1) q(1) r],'String','sin(x)', ...
   'CallBack','lineartool2(''row1'',''sin'')');
uicontrol('Position',[p(2) q(1) r],'String','cos(x)', ...  
   'CallBack','lineartool2(''row1'',''cos'')');
uicontrol('Position',[p(3) q(1) r],'String','atan(x)', ...  
   'CallBack','lineartool2(''row1'',''atan'')');
uicontrol('Position',[p(4) q(1) r],'String','sin(x^2)', ...  
   'CallBack','lineartool2(''row1'',''sinxsq'')');
uicontrol('Position',[p(5) q(1) r],'String','cos(x^2)', ...  
   'CallBack','lineartool2(''row1'',''cosxsq'')');
uicontrol('Position',[p(6) q(1) r],'String','atan(x^2)', ...  
   'CallBack','lineartool2(''row1'',''atanxsq'')');

% Second row operators. 
uicontrol('Position',[p(1) q(2) r],'String','a++', ...
    'CallBack','lineartool2 aplusplus');
uicontrol('Position',[p(2) q(2) r],'String','a--', ...
    'CallBack','lineartool2 aminusminus');
uicontrol('Position',[p(3) q(2) r],'String','Reset a', ...
    'CallBack','lineartool2 centera');
uicontrol('Style','checkbox','Position',[p(6) q(2) r],'String','Legend', ...
    'CallBack','lineartool2 legend','Value',1,'Tag','SLegend');

% Third row operators. 
uicontrol('Position',[p(1) q(3) r],'String','Zoom In', ...  
          'CallBack','lineartool2 zoomin');
uicontrol('Position',[p(2) q(3) r],'String','Zoom Out', ...
          'CallBack','lineartool2 zoomout');
uicontrol('Position',[p(3) q(3) r],'String','delta=0.5', ...
          'CallBack','lineartool2 deltaonehalf');
uicontrol('Position',[p(6) q(3) r],'String','Close', ...
    'CallBack','lineartool2 close');

% plot
linearplot(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr,epsilonstr,fig1,fig2);
secondplot(LINEARTOOL2_figp,fstr,astr,deltastr,xlimstr,fig3);

%%%%%%%%%%%%%%%%%%%%%%%%%%  end of Initialization section

else

    LINEARTOOL2_figp = findobj(0,'Tag','LINEARTOOL2_figp');

switch keyword

%%%%%%%%%%%%%%%%%%%%%%%%%%  Callback for first row of unary operators.
  
case 'row1'
  switch varargin{1}
    case 'sin'
     fstr = 'sin(x)';
     astr = '0';
     lstr = getlinear(fstr,astr);
     deltastr = '0.5';
     xlimstr = '[-pi,pi]';
     epsilonstr = '0.1';
    case 'cos'
     fstr = 'cos(x)';
     astr = '0';
     lstr = getlinear(fstr,astr);
     deltastr = '0.5';
     xlimstr = '[-pi,pi]';
     epsilonstr = '0.1';
    case 'atan'
     fstr = 'atan(x)';
     astr = '0';
     lstr = getlinear(fstr,astr);     
     deltastr = '0.5';
     xlimstr = '[-3,3]';
     epsilonstr = '0.1';
    case 'sinxsq'
     fstr = 'sin(x^2)';
     astr = '0';
     lstr = getlinear(fstr,astr);
     deltastr = '0.5';
     xlimstr = '[-3,3]';
     epsilonstr = '0.1';
    case 'cosxsq'
     fstr = 'cos(x^2)';
     astr = '0';
     lstr = getlinear(fstr,astr);
     deltastr = '0.5';
     xlimstr = '[-3,3]';
     epsilonstr = '0.1';
    case 'atanxsq'
     fstr = 'atan(x^2)';
     astr = '0';
     lstr = getlinear(fstr,astr);
     deltastr = '0.5';
     xlimstr = '[-3,3]';
     epsilonstr = '0.1';
   end

   fig1 = findobj(0,'Tag','fig1');
   fig2 = findobj(0,'Tag','fig2');   
   fig3 = findobj(0,'Tag','fig3');
   linearplot(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr, ...
              epsilonstr,fig1,fig2);
   secondplot(LINEARTOOL2_figp,fstr,astr,deltastr,xlimstr,fig3);   
   setall(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr,epsilonstr)   

%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for f's edit text box.
  
  case 'Sfcallback'

    [fstr,lstr,astr,deltastr,xlimstr,epsilonstr] = getall(LINEARTOOL2_figp);
    lstr = getlinear(fstr,astr);
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');   
    fig3 = findobj(0,'Tag','fig3');
    linearplot(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr, ...
               epsilonstr,fig1,fig2);
    secondplot(LINEARTOOL2_figp,fstr,astr,deltastr,xlimstr,fig3);   
    setall(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr,epsilonstr)   
    
%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for a's edit text box.
  
  case 'Sacallback'

    [fstr,lstr,astr,deltastr,xlimstr,epsilonstr] = getall(LINEARTOOL2_figp);
    lstr = getlinear(fstr,astr);
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');   
    fig3 = findobj(0,'Tag','fig3');
    linearplot(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr, ...
               epsilonstr,fig1,fig2);
    secondplot(LINEARTOOL2_figp,fstr,astr,deltastr,xlimstr,fig3);   
    setall(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr,epsilonstr)   


%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for delta's edit text box.
  
  case 'Sdeltacallback'

    [fstr,lstr,astr,deltastr,xlimstr,epsilonstr] = getall(LINEARTOOL2_figp);
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');
    fig3 = findobj(0,'Tag','fig3');            
    linearplot(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr, ...
               epsilonstr,fig1,fig2);
    secondplot(LINEARTOOL2_figp,fstr,astr,deltastr,xlimstr,fig3);       
    setall(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr,epsilonstr);
    
%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for xlim's edit text box.
  
  case 'Sxlimcallback'

    [fstr,lstr,astr,deltastr,xlimstr,epsilonstr] = getall(LINEARTOOL2_figp);
    xlimarr = str2num(xlimstr);
    a = xlimarr(1);
    b = xlimarr(2);
    aval = a+(b-a)/2;
    astr = num2str(aval);
    lstr = getlinear(fstr,astr);    
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');      
    fig3 = findobj(0,'Tag','fig3');          
    linearplot(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr, ...
               epsilonstr,fig1,fig2);    
    secondplot(LINEARTOOL2_figp,fstr,astr,deltastr,xlimstr,fig3);           
    setall(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr,epsilonstr);
    
%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for epsilon's edit text box.

  case 'Sepsiloncallback'

    [fstr,lstr,astr,deltastr,xlimstr,epsilonstr] = getall(LINEARTOOL2_figp);
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');
    fig3 = findobj(0,'Tag','fig3');              
    linearplot(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr, ...
               epsilonstr,fig1,fig2);    
    secondplot(LINEARTOOL2_figp,fstr,astr,deltastr,xlimstr,fig3);               
    setall(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr,epsilonstr);
   
%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for zoomin button.

  case 'zoomin'

    [fstr,lstr,astr,deltastr,xlimstr,epsilonstr] = getall(LINEARTOOL2_figp);
    deltaval = str2num(deltastr);
    deltaval = deltaval/2;
    deltastr = num2str(deltaval);
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');      
    fig3 = findobj(0,'Tag','fig3');                  
    linearplot(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr, ...
               epsilonstr,fig1,fig2);    
    secondplot(LINEARTOOL2_figp,fstr,astr,deltastr,xlimstr,fig3);                   
    setall(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr,epsilonstr);

%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for zoomout button.

  case 'zoomout'

    [fstr,lstr,astr,deltastr,xlimstr,epsilonstr] = getall(LINEARTOOL2_figp);
    deltaval = str2num(deltastr);
    deltaval = deltaval*2;
    deltastr = num2str(deltaval);
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');      
    fig3 = findobj(0,'Tag','fig3');                      
    linearplot(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr, ...
               epsilonstr,fig1,fig2);    
    secondplot(LINEARTOOL2_figp,fstr,astr,deltastr,xlimstr,fig3);                       
    setall(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr,epsilonstr);
    
%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for deltaonehalf button.

  case 'deltaonehalf'

    [fstr,lstr,astr,deltastr,xlimstr,epsilonstr] = getall(LINEARTOOL2_figp);
    deltastr = '0.5';
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');      
    fig3 = findobj(0,'Tag','fig3');                          
    linearplot(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr, ...
               epsilonstr,fig1,fig2);    
    secondplot(LINEARTOOL2_figp,fstr,astr,deltastr,xlimstr,fig3);                           
    setall(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr,epsilonstr);
    
%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for aplusplus button.

  case 'aplusplus'

    [fstr,lstr,astr,deltastr,xlimstr,epsilonstr] = getall(LINEARTOOL2_figp);
    xlimarr = str2num(xlimstr);
    a = xlimarr(1);
    b = xlimarr(2);
    aval = str2num(astr);
    deltaval = str2num(deltastr);    
    if (aval + 2*deltaval <= b)
      aval = aval + deltaval;
      astr = num2str(aval);
      lstr = getlinear(fstr,astr);
    end;
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');      
    fig3 = findobj(0,'Tag','fig3');                              
    linearplot(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr, ...
               epsilonstr,fig1,fig2);    
    secondplot(LINEARTOOL2_figp,fstr,astr,deltastr,xlimstr,fig3);                               
    setall(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr,epsilonstr);

%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for aminusminus button.

  case 'aminusminus'

    [fstr,lstr,astr,deltastr,xlimstr,epsilonstr] = getall(LINEARTOOL2_figp);
    xlimarr = str2num(xlimstr);
    a = xlimarr(1);
    b = xlimarr(2);
    aval = str2num(astr);
    deltaval = str2num(deltastr);
    if (aval - 2*deltaval >= a)
      aval = aval - deltaval;
      astr = num2str(aval);
      lstr = getlinear(fstr,astr);
    end;
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');      
    fig3 = findobj(0,'Tag','fig3');                                  
    linearplot(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr, ...
               epsilonstr,fig1,fig2);    
    secondplot(LINEARTOOL2_figp,fstr,astr,deltastr,xlimstr,fig3);                               
    setall(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr,epsilonstr);

%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for centera button.   
  
  case 'centera'

    [fstr,lstr,astr,deltastr,xlimstr,epsilonstr] = getall(LINEARTOOL2_figp);
    xlimarr = str2num(xlimstr);
    a = xlimarr(1);
    b = xlimarr(2);
    aval = a+(b-a)/2;
    astr = num2str(aval);
    lstr = getlinear(fstr,astr);    
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');      
    fig3 = findobj(0,'Tag','fig3');                                      
    linearplot(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr, ...
               epsilonstr,fig1,fig2);    
    secondplot(LINEARTOOL2_figp,fstr,astr,deltastr,xlimstr,fig3);
    setall(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr,epsilonstr);

%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for Legend button.   
  
  case 'legend'

    [fstr,lstr,astr,deltastr,xlimstr,epsilonstr] = getall(LINEARTOOL2_figp);
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');      
    fig3 = findobj(0,'Tag','fig3');                                      
    linearplot(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr, ...
               epsilonstr,fig1,fig2);    
    secondplot(LINEARTOOL2_figp,fstr,astr,deltastr,xlimstr,fig3);    
    setall(LINEARTOOL2_figp,fstr,lstr,astr,deltastr,xlimstr,epsilonstr);
    
%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for Close button.
  
case 'close'
   delete(findobj(0,'Tag','fig1')); 
   delete(findobj(0,'Tag','fig2')); 
   delete(findobj(0,'Tag','fig3'));    
   delete(findobj(0,'Tag','LINEARTOOL2_figp')); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end % switch statement for callbacks

end     % end of if statement

function [fstr,lstr,astr,deltastr,xlimstr,epsilonstr] = getall(lineartool2)
  fstr = get(findobj(lineartool2,'Tag','Sfstr'),'String');
  lstr = get(findobj(lineartool2,'Tag','Slstr'),'String');
  astr = get(findobj(lineartool2,'Tag','Sastr'),'String');
  deltastr = get(findobj(lineartool2,'Tag','Sdeltastr'),'String');  
  xlimstr = get(findobj(lineartool2,'Tag','Sxlimstr'),'String');
  epsilonstr = get(findobj(lineartool2,'Tag','Sepsilonstr'),'String');
  
function setall(lineartool2,fstr,lstr,astr,deltastr,xlimstr,epsilonstr)
  set(findobj(lineartool2,'Tag','Sfstr'),'String',fstr);
  set(findobj(lineartool2,'Tag','Slstr'),'String',lstr);
  set(findobj(lineartool2,'Tag','Sastr'),'String',astr);
  set(findobj(lineartool2,'Tag','Sdeltastr'),'String',deltastr);
  set(findobj(lineartool2,'Tag','Sxlimstr'),'String',xlimstr);
  set(findobj(lineartool2,'Tag','Sepsilonstr'),'String',epsilonstr);  
  
function linearplot(lineartool2,fstr,lstr,astr,deltastr,xlimstr,epsilonstr,fig1,fig2)
  syms x;
  fsym = sym(fstr);
  lsym = sym(lstr);
  center = str2num(astr);
  deltaval = str2num(deltastr);
  epsilonval = str2num(epsilonstr);
  fcenter = double(subs(fsym,x,center));
  xlimarr = str2num(xlimstr);
  a = xlimarr(1);
  b = xlimarr(2);
  a2 = center-deltaval;
  b2 = center+deltaval;
  plotn = 200;
  deltaxplot = (b-a)/plotn;
  xvalplot = a+deltaxplot.*[0:plotn];  
  yvalplotf = double(subs(fsym,x,xvalplot));
  yvalplotl = double(subs(lsym,x,xvalplot));  
  maxy = max(yvalplotf);
  miny = min(yvalplotf);
  eps = (maxy-miny)*0.05;
  c = miny-eps;
  d = maxy+eps;
  plotn2 = 100;
  deltaxplot2 = 2*deltaval/plotn2;
  xvalplot2 = a2+deltaxplot2.*[0:plotn2];
  yvalplotf2 = double(subs(fsym,x,xvalplot2));
  yvalplotf2_a = yvalplotf2+epsilonval;
  yvalplotf2_b = yvalplotf2-epsilonval;
  yvalplotl2 = double(subs(lsym,x,xvalplot2));
  maxy2 = max(yvalplotf2_a);
  miny2 = min(yvalplotf2_b);
  eps2 = (maxy2-miny2)*0.05;
  c2 = miny2-eps2;
  d2 = maxy2+eps2;
  figure(fig1);
  plot(xvalplot,yvalplotf,'LineWidth',2.0);
  axis([a,b,c,d]);
  hold all;
  plot(xvalplot,yvalplotl,'LineWidth',2.0,'color','magenta');
  scatter([center],[fcenter],80,'MarkerEdgeColor','b','MarkerFaceColor','c','LineWidth',2.0);
  plot([a2,a2,b2,b2,a2],[c,d,d,c,c],'LineWidth',1.0,'color','r');
  handle = findobj(lineartool2,'Tag','SLegend');
  value = get(handle,'Value');
  if value==get(handle,'Max')
      legend('\fontsize{18} f(x)','\fontsize{18} L(x)','Location','NorthWest');
  end;
  hold off;

  % zoom plot
  figure(fig2);
  plot(xvalplot2,yvalplotf2,'LineWidth',2.0);
  axis([a2,b2,c2,d2]);
  hold all;
  plot(xvalplot2,yvalplotl2,'LineWidth',2.0,'color','magenta');
  plot(xvalplot2,yvalplotf2_a,'color',[0,0.9,0.1]);
  plot(xvalplot2,yvalplotf2_b,'color',[0,0.9,0.1]);  
  scatter([center],[fcenter],80,'MarkerEdgeColor','b', ...
          'MarkerFaceColor','c','LineWidth',2.0);
  if value==get(handle,'Max')
      legend('\fontsize{18} f(x)','\fontsize{18} L(x)','Location','NorthWest');
  end;
  hold off;

function [lstr] = getlinear(fstr,astr)
  syms x;
  fsym = sym(fstr);
  center = str2num(astr);
  fcenter = subs(fsym,x,center);
  fpsym = diff(fsym,x);
  fpcenter = subs(fpsym,x,center);
  lstr = char(fcenter+fpcenter*(x-center));  

function [secondstr] = getsecond(fstr)
    syms x;
    fsym = sym(fstr);
    fpsym = diff(fsym,x);
    fppsym = diff(fpsym,x);
    secondstr = char(fppsym);

function secondplot(lineartool2,fstr,astr,deltastr,xlimstr,fig3)
  syms x;
  secondstr = getsecond(fstr);
  gstr = strcat('abs(',secondstr,')');
  gsym = sym(gstr);
  center = str2num(astr);
  deltaval = str2num(deltastr);
  xlimarr = str2num(xlimstr);
  a = xlimarr(1);
  b = xlimarr(2);
  a2 = center-deltaval;
  b2 = center+deltaval;
  plotn = 200;
  deltaxplot = (b-a)/plotn;  
  xvalplot = a+deltaxplot.*[0:plotn];
  yvalplot = double(subs(gsym,x,xvalplot));
  maxy = max(yvalplot);
  eps = maxy*0.05;
  c = 0;
  d = maxy+eps;
  figure(fig3);
  plot(xvalplot,yvalplot,'LineWidth',2.0,'color','blue');
  hold all;
  plot([a2,a2,b2,b2,a2],[c,d,d,c,c],'LineWidth',1.0,'color','r');  
  axis([a,b,c,d]);
  title('\fontsize{18} | f ''''(x) |');
  hold off;
