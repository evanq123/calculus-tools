function tpolytool(keyword,varargin)

%%%%%%%%%%%%%%%%%%%%%%%%%%  Initialization section.

set(0,'DefaultUIControlFontSize',18);    

if nargin == 0
   
H = findobj(0,'Tag','TPOLYTOOL_figp');
if ~isempty(H)
   warning('symbolic:tpolytool:Started','Another TPOLYTOOL is running.  Only 1 TPOLYTOOL can be run at a time.');
   return
end

fstr = 'exp(x)';
nstr = '1';
astr = '0';
tstr = gettpoly(fstr,astr,nstr);
zoomstr = '[-1,1]';
xlimstr = '[-4,4]';
epsilonstr = '0.2';

% Macros
p = .14*(1:6) - .06;
q = .60 - .14*(1:4);
r = [.14 .10];

% Position the figures and the control panel.
fig1 = figure('name','tpolytool : Overview','NumberTitle','off','Units','normalized','Position',[.01 .54 .48 .40],...
              'Menu','none','Tag','fig1');
set(fig1,'CloseRequestFcn','tpolytool close');

fig2 = figure('name','tpolytool : Zoom','NumberTitle','off', ...
              'Units','normalized','Position',[.50 .54 .48 .40],...
              'Menu','none','Tag','fig2');
set(fig2,'CloseRequestFcn','tpolytool close');

fig3 = figure('name','tpolytool2 : Zoom Error','NumberTitle','off', ...
              'Units','normalized','Position', [.50 .10 .48 .40],...
              'Menu','none','Tag','fig3');
set(fig3,'CloseRequestFcn','tpolytool2 close');

TPOLYTOOL_figp = figure('name','tpolytool','NumberTitle','off','Units','normalized','Position',[.01 .10 .48 .40],'Menu','none', ...
              'Tag','TPOLYTOOL_figp',...
              'Color',get(0,'DefaultUIControlBackgroundColor'), ...
              'DefaultUIControlUnit','norm');

set(TPOLYTOOL_figp,'CloseRequestFcn','tpolytool close');

% Control panel
figure(TPOLYTOOL_figp);
axes('Parent',TPOLYTOOL_figp,'Visible','off');
uicontrol('Style','frame','Position',[0.01 0.60 0.98 0.38]);
uicontrol('Style','frame','Position',[0.01 0.01 0.98 0.58]);
uicontrol('Style','text','String','f(x)','Position',[0.04 0.86 0.09 ...
                    0.10],'Tag','tstr','UserData',tstr);
uicontrol('Style','text','String','n','Position',[0.52 0.86 0.09 0.10]);
uicontrol('Style','text','String','zoom','Position',[0.52 0.62 0.09 0.10]);
uicontrol('Style','text','String','a','Position',[0.04 0.74 0.09 ...
                    0.10]);
uicontrol('Style','text','String','xlim','Position',[0.04 0.62 0.09 0.10]);
uicontrol('Style','text','String','epsilon','Position',[0.52 0.74 0.09 0.10]);
uicontrol('Position',[.12 .86 .32 .10],'Style','edit', ...
          'HorizontalAlignment','left','BackgroundColor','white', ...
          'String',fstr,'Tag','Sfstr', 'CallBack','tpolytool Sfcallback');
uicontrol('Position',[.62 .86 .32 .10],'Style','edit', ...
          'HorizontalAlignment','left','BackgroundColor','white', ...
          'String',nstr,'Tag','Snstr', 'CallBack','tpolytool Sncallback');
uicontrol('Position',[.12 .74 .32 .10],'Style','edit','HorizontalAlignment','left', ...
    'BackgroundColor','white','String',astr,'Tag','Sastr','CallBack','tpolytool Sacallback');
uicontrol('Position',[.62 .62 .32 .10],'Style','edit','HorizontalAlignment','left', ...
    'BackgroundColor','white','String',zoomstr,'Tag','Szoomstr','CallBack','tpolytool Szoomcallback');
uicontrol('Position',[.12 .62 .32 .10],'Style','edit','HorizontalAlignment','left', ...
    'BackgroundColor','white','String',xlimstr, 'Tag','Sxlimstr',...
    'CallBack','tpolytool Sxlimcallback');
uicontrol('Position',[.62 .74 .32 .10],'Style','edit','HorizontalAlignment','left', ...
    'BackgroundColor','white','String',epsilonstr, 'Tag','Sepsilonstr',...
    'CallBack','tpolytool Sepsiloncallback');

% First row operators. 
uicontrol('Position',[p(1) q(1) r],'String','exp(x)', ...
   'CallBack','tpolytool(''row1'',''exp'')');
uicontrol('Position',[p(2) q(1) r],'String','sin(x)', ...
   'CallBack','tpolytool(''row1'',''sin'')');
uicontrol('Position',[p(3) q(1) r],'String','cos(x)', ...  
   'CallBack','tpolytool(''row1'',''cos'')');
uicontrol('Position',[p(4) q(1) r],'String','1/(1-x)', ...  
   'CallBack','tpolytool(''row1'',''geom'')');
uicontrol('Position',[p(5) q(1) r],'String','atan(x)', ...  
   'CallBack','tpolytool(''row1'',''atan'')');
uicontrol('Position',[p(6) q(1) r],'String','log(1+x)', ...  
   'CallBack','tpolytool(''row1'',''log'')');

% Second row operators. 
uicontrol('Position',[p(1) q(2) r],'String','exp(x^2)', ...
   'CallBack','tpolytool(''row2'',''expsq'')');
uicontrol('Position',[p(2) q(2) r],'String','sin(x^2)', ...
   'CallBack','tpolytool(''row2'',''sinsq'')');
uicontrol('Position',[p(3) q(2) r],'String','cos(x^2)', ...  
   'CallBack','tpolytool(''row2'',''cossq'')');
uicontrol('Position',[p(4) q(2) r],'String','sqrt(x^2+4)', ...
   'CallBack','tpolytool(''row2'',''sqrt1'')');

% Third row operators. 
uicontrol('Position',[p(1) q(3) r],'String','Zoom In', ...  
          'CallBack','tpolytool zoomin');
uicontrol('Position',[p(2) q(3) r],'String','Zoom Out', ...
          'CallBack','tpolytool zoomout');
uicontrol('Position',[p(3) q(3) r],'String','Max', ...
          'CallBack','tpolytool zoommax');
uicontrol('Position',[p(4) q(3) r],'String','Left', ...
          'CallBack','tpolytool zoomleft');
uicontrol('Position',[p(5) q(3) r],'String','Right', ...
          'CallBack','tpolytool zoomright');

% Fourth row operators. 
uicontrol('Position',[p(1) q(4) r],'String','n++', ...
    'CallBack','tpolytool nplusplus');
uicontrol('Position',[p(2) q(4) r],'String','n--', ...
    'CallBack','tpolytool nminusminus');
uicontrol('Position',[p(3) q(4) r],'String','n=1', ...
    'CallBack','tpolytool onen');
uicontrol('Style','checkbox','Position',[p(5)+.01 q(4) r],'String','Legend', ...
    'CallBack','tpolytool legend','Value',1,'Tag','SLegend');
uicontrol('Position',[p(6) q(4) r],'String','Close', ...
    'CallBack','tpolytool close');


% plot
tpolyplot(TPOLYTOOL_figp,fstr,tstr,astr,zoomstr,xlimstr,epsilonstr,fig1,fig2);
errorplot(fstr,tstr,astr,zoomstr,epsilonstr,fig3);

%%%%%%%%%%%%%%%%%%%%%%%%%%  end of Initialization section

else

    TPOLYTOOL_figp = findobj(0,'Tag','TPOLYTOOL_figp');

switch keyword

%%%%%%%%%%%%%%%%%%%%%%%%%%  Callback for first row of unary operators.
  
  case 'row1'

    [fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr] = getall(TPOLYTOOL_figp);
    
  switch varargin{1}
    case 'exp'
      fstr = 'exp(x)';
      nstr = '1';
      astr = '0';
      tstr = gettpoly(fstr,astr,nstr);
      zoomstr = '[-1,1]';
      xlimstr = '[-4,4]';
      epsilonstr = '0.2';
    case 'sin'
      fstr = 'sin(x)';
      nstr = '1';
      astr = '0';
      tstr = gettpoly(fstr,astr,nstr);
      zoomstr = '[-2,2]';
      xlimstr = '[-8,8]';
      epsilonstr = '0.2';
    case 'cos'
      fstr = 'cos(x)';
      nstr = '1';
      astr = '0';
      tstr = gettpoly(fstr,astr,nstr);
      zoomstr = '[-2,2]';
      xlimstr = '[-8,8]';
      epsilonstr = '0.2';
    case 'geom'
      fstr = '1/(1-x)';
      nstr = '1';
      astr = '0';
      tstr = gettpoly(fstr,astr,nstr);
      zoomstr = '[-3/4,3/4]';
      xlimstr = '[-5/4,3/4]';
      epsilonstr = '0.2';
    case 'atan'
      fstr = 'atan(x)';
      nstr = '1';
      astr = '0';
      tstr = gettpoly(fstr,astr,nstr);
      zoomstr = '[-3/4,3/4]';
      xlimstr = '[-5/4,5/4]';
      epsilonstr = '0.1';
    case 'log'
      fstr = 'log(1+x)';
      nstr = '1';
      astr = '0';
      tstr = gettpoly(fstr,astr,nstr);
      zoomstr = '[-3/4,3/4]';
      xlimstr = '[-3/4,5/4]';
      epsilonstr = '0.1';
   end

   fig1 = findobj(0,'Tag','fig1');
   fig2 = findobj(0,'Tag','fig2');   
   fig3 = findobj(0,'Tag','fig3');      
   tpolyplot(TPOLYTOOL_figp,fstr,tstr,astr,zoomstr,xlimstr, ...
              epsilonstr,fig1,fig2);
   errorplot(fstr,tstr,astr,zoomstr,epsilonstr,fig3);   
   setall(TPOLYTOOL_figp,fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr)   

%%%%%%%%%%%%%%%%%%%%%%%%%%  Callback for second row of unary operators.
  
  case 'row2'

    [fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr] = getall(TPOLYTOOL_figp);
    
  switch varargin{1}
    case 'expsq'
      fstr = 'exp(x^2)';
      nstr = '1';
      astr = '0';
      tstr = gettpoly(fstr,astr,nstr);
      zoomstr = '[0,1/2]';
      xlimstr = '[0,2]';
      epsilonstr = '0.02';
    case 'sinsq'
      fstr = 'sin(x^2)';
      nstr = '1';
      astr = '0';
      tstr = gettpoly(fstr,astr,nstr);
      zoomstr = '[0,1/2]';
      xlimstr = '[0,2]';
      epsilonstr = '0.02';
    case 'cossq'
      fstr = 'cos(x^2)';
      nstr = '1';
      astr = '0';
      tstr = gettpoly(fstr,astr,nstr);
      zoomstr = '[0,1/2]';
      xlimstr = '[0,2]';
      epsilonstr = '0.005';
    case 'sqrt1'
      fstr = 'sqrt(x^2+4)';
      nstr = '1';
      astr = '0';
      tstr = gettpoly(fstr,astr,nstr);
      zoomstr = '[0,1/2]';
      xlimstr = '[0,2]';
      epsilonstr = '0.005';
   end

   fig1 = findobj(0,'Tag','fig1');
   fig2 = findobj(0,'Tag','fig2');   
   fig3 = findobj(0,'Tag','fig3');      
   tpolyplot(TPOLYTOOL_figp,fstr,tstr,astr,zoomstr,xlimstr, ...
              epsilonstr,fig1,fig2);
   errorplot(fstr,tstr,astr,zoomstr,epsilonstr,fig3);   
   setall(TPOLYTOOL_figp,fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr)   

%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for f's edit text box.
  
  case 'Sfcallback'

    [fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr] = getall(TPOLYTOOL_figp);
    tstr = gettpoly(fstr,astr,nstr);
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');   
    fig3 = findobj(0,'Tag','fig3');          
    tpolyplot(TPOLYTOOL_figp,fstr,tstr,astr,zoomstr,xlimstr, ...
               epsilonstr,fig1,fig2);
    errorplot(fstr,tstr,astr,zoomstr,epsilonstr,fig3);    
    setall(TPOLYTOOL_figp,fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr)   
    

%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for t's edit text box.
  
  case 'Stcallback'

    [fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr] = getall(TPOLYTOOL_figp);
    tstr = gettpoly(fstr,astr,nstr);
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');   
    fig3 = findobj(0,'Tag','fig3');          
    tpolyplot(TPOLYTOOL_figp,fstr,tstr,astr,zoomstr,xlimstr, ...
               epsilonstr,fig1,fig2);
    errorplot(fstr,tstr,astr,zoomstr,epsilonstr,fig3);    
    setall(TPOLYTOOL_figp,fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr)   
    

%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for n's edit text box.
  
  case 'Sncallback'

    [fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr] = getall(TPOLYTOOL_figp);
    nval = str2num(nstr);
    if (nval < 1)
        nval = 1;
        nstr = num2str(nval);        
    end;
    if (nval > 50)
        nval = 50;
        nstr = num2str(nval);        
    end;
    tstr = gettpoly(fstr,astr,nstr);
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');   
    fig3 = findobj(0,'Tag','fig3');          
    tpolyplot(TPOLYTOOL_figp,fstr,tstr,astr,zoomstr,xlimstr, ...
               epsilonstr,fig1,fig2);
    errorplot(fstr,tstr,astr,zoomstr,epsilonstr,fig3);    
    setall(TPOLYTOOL_figp,fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr)   


%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for a's edit text box.
  
  case 'Sacallback'

    [fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr] = getall(TPOLYTOOL_figp);

    aval = str2num(astr);
    xlimarr = str2num(xlimstr);
    xlim_a = xlimarr(1);
    xlim_b = xlimarr(2);
    
    delta = (xlim_b-xlim_a)/2.0;

    zoomstr = [ '[', num2str(aval-delta), ',', num2str(aval+delta), ']' ];
    xlimstr = [ '[', num2str(aval-delta), ',', num2str(aval+delta), ']' ];
    
    tstr = gettpoly(fstr,astr,nstr);
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');   
    fig3 = findobj(0,'Tag','fig3');          
    tpolyplot(TPOLYTOOL_figp,fstr,tstr,astr,zoomstr,xlimstr, ...
               epsilonstr,fig1,fig2);
    errorplot(fstr,tstr,astr,zoomstr,epsilonstr,fig3);    
    setall(TPOLYTOOL_figp,fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr)   


%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for zoom's edit text box.
  
  case 'Szoomcallback'

    [fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr] = ...
        getall(TPOLYTOOL_figp);
    
    xlimarr = str2num(xlimstr);
    zoomarr = str2num(zoomstr);
    zoom_a = zoomarr(1);
    zoom_b = zoomarr(2);
    xlim_a = xlimarr(1);
    xlim_b = xlimarr(2);
    if (zoom_a < xlim_a)
        zoom_a = xlim_a;
    end;
    if (zoom_b > xlim_b)
        zoom_b = xlim_b;
    end;
    zoomstr = [ '[', num2str(zoom_a), ',', num2str(zoom_b), ']' ];              
              
    tstr = gettpoly(fstr,astr,nstr);    
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');
    fig3 = findobj(0,'Tag','fig3');          
    tpolyplot(TPOLYTOOL_figp,fstr,tstr,astr,zoomstr,xlimstr, ...
               epsilonstr,fig1,fig2);
    errorplot(fstr,tstr,astr,zoomstr,epsilonstr,fig3);        
    setall(TPOLYTOOL_figp,fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr);
    
%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for xlim's edit text box.
  
  case 'Sxlimcallback'

    [fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr] = ...
        getall(TPOLYTOOL_figp);
    
    xlimarr = str2num(xlimstr);
    xlim_a = xlimarr(1);
    xlim_b = xlimarr(2);
    zoomstr = [ '[', num2str(xlim_a), ',', num2str(xlim_b), ']' ];    

    tstr = gettpoly(fstr,astr,nstr);    
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');      
    fig3 = findobj(0,'Tag','fig3');          
    tpolyplot(TPOLYTOOL_figp,fstr,tstr,astr,zoomstr,xlimstr, ...
               epsilonstr,fig1,fig2);    
    errorplot(fstr,tstr,astr,zoomstr,epsilonstr,fig3);        
    setall(TPOLYTOOL_figp,fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr);
    
%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for epsilon's edit text box.

  case 'Sepsiloncallback'

    [fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr] = getall(TPOLYTOOL_figp);
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');
    fig3 = findobj(0,'Tag','fig3');          
    tpolyplot(TPOLYTOOL_figp,fstr,tstr,astr,zoomstr,xlimstr, ...
               epsilonstr,fig1,fig2);    
    errorplot(fstr,tstr,astr,zoomstr,epsilonstr,fig3);        
    setall(TPOLYTOOL_figp,fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr);
   
%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for zoomin button.

  case 'zoomin'

    [fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr] = getall(TPOLYTOOL_figp);
    
    zoomarr = str2num(zoomstr);
    zoom_a = zoomarr(1);
    zoom_b = zoomarr(2);
    delta = (zoom_b-zoom_a)/2.0;
    center = zoom_a + delta;
    zoom_a = center-delta/2.0;
    zoom_b = center+delta/2.0;
    zoomstr = [ '[', num2str(zoom_a), ',', num2str(zoom_b), ']' ];
    
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');      
    fig3 = findobj(0,'Tag','fig3');          
    tpolyplot(TPOLYTOOL_figp,fstr,tstr,astr,zoomstr,xlimstr, ...
               epsilonstr,fig1,fig2);    
    errorplot(fstr,tstr,astr,zoomstr,epsilonstr,fig3);        
    setall(TPOLYTOOL_figp,fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr);

%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for zoomout button.

  case 'zoomout'

    [fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr] = getall(TPOLYTOOL_figp);

    zoomarr = str2num(zoomstr);
    zoom_a = zoomarr(1);
    zoom_b = zoomarr(2);
    delta = (zoom_b-zoom_a)/2.0;
    center = zoom_a + delta;
    zoom_a = center-delta*2.0;
    zoom_b = center+delta*2.0;
    
    xlimarr = str2num(xlimstr);
    xlim_a = xlimarr(1);
    xlim_b = xlimarr(2);
    if (zoom_a < xlim_a)
        zoom_a = xlim_a;
    end;
    if (zoom_b > xlim_b)
        zoom_b = xlim_b;
    end;
    
    zoomstr = [ '[', num2str(zoom_a), ',', num2str(zoom_b), ']' ];
    
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');      
    fig3 = findobj(0,'Tag','fig3');          
    tpolyplot(TPOLYTOOL_figp,fstr,tstr,astr,zoomstr,xlimstr, ...
               epsilonstr,fig1,fig2);    
    errorplot(fstr,tstr,astr,zoomstr,epsilonstr,fig3);        
    setall(TPOLYTOOL_figp,fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr);
    
%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for zoomleft button.

  case 'zoomleft'

    [fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr] = getall(TPOLYTOOL_figp);

    xlimarr = str2num(xlimstr);
    xlim_a = xlimarr(1);
    xlim_b = xlimarr(2);
    
    zoomarr = str2num(zoomstr);
    zoom_a = zoomarr(1);
    zoom_b = zoomarr(2);
    delta1 = (zoom_b-zoom_a)/2.0;
    delta2 = (zoom_a-xlim_a);
    delta = min(delta1,delta2);
    zoom_a = zoom_a-delta;
    zoom_b = zoom_b-delta;

    zoomstr = [ '[', num2str(zoom_a), ',', num2str(zoom_b), ']' ];
    
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');      
    fig3 = findobj(0,'Tag','fig3');          
    tpolyplot(TPOLYTOOL_figp,fstr,tstr,astr,zoomstr,xlimstr, ...
               epsilonstr,fig1,fig2);    
    errorplot(fstr,tstr,astr,zoomstr,epsilonstr,fig3);        
    setall(TPOLYTOOL_figp,fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr);
    

%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for zoomright button.

  case 'zoomright'

    [fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr] = getall(TPOLYTOOL_figp);

    xlimarr = str2num(xlimstr);
    xlim_a = xlimarr(1);
    xlim_b = xlimarr(2);
    
    zoomarr = str2num(zoomstr);
    zoom_a = zoomarr(1);
    zoom_b = zoomarr(2);
    delta1 = (zoom_b-zoom_a)/2.0;
    delta2 = (xlim_b-zoom_b);
    delta = min(delta1,delta2);
    zoom_a = zoom_a+delta;
    zoom_b = zoom_b+delta;

    zoomstr = [ '[', num2str(zoom_a), ',', num2str(zoom_b), ']' ];
    
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');      
    fig3 = findobj(0,'Tag','fig3');          
    tpolyplot(TPOLYTOOL_figp,fstr,tstr,astr,zoomstr,xlimstr, ...
               epsilonstr,fig1,fig2);    
    errorplot(fstr,tstr,astr,zoomstr,epsilonstr,fig3);        
    setall(TPOLYTOOL_figp,fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr);
    

%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for zoommax button.

  case 'zoommax'

    [fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr] = getall(TPOLYTOOL_figp);

    xlimarr = str2num(xlimstr);
    xlim_a = xlimarr(1);
    xlim_b = xlimarr(2);
    zoomstr = [ '[', num2str(xlim_a), ',', num2str(xlim_b), ']' ];
    
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');      
    fig3 = findobj(0,'Tag','fig3');          
    tpolyplot(TPOLYTOOL_figp,fstr,tstr,astr,zoomstr,xlimstr, ...
               epsilonstr,fig1,fig2);    
    errorplot(fstr,tstr,astr,zoomstr,epsilonstr,fig3);        
    setall(TPOLYTOOL_figp,fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr);
    

%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for nplusplus button.

  case 'nplusplus'

    [fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr] = getall(TPOLYTOOL_figp);
    nval = str2num(nstr);
    nval = nval + 1;
    nstr = num2str(nval);
    tstr = gettpoly(fstr,astr,nstr);
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');      
    fig3 = findobj(0,'Tag','fig3');          
    tpolyplot(TPOLYTOOL_figp,fstr,tstr,astr,zoomstr,xlimstr, ...
               epsilonstr,fig1,fig2);    
    errorplot(fstr,tstr,astr,zoomstr,epsilonstr,fig3);        
    setall(TPOLYTOOL_figp,fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr);


%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for nminusminus button.

  case 'nminusminus'

    [fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr] = getall(TPOLYTOOL_figp);
    nval = str2num(nstr);
    if (nval > 1)
        nval = nval - 1;
    else
        nval = 1;
    end;
    nstr = num2str(nval);
    tstr = gettpoly(fstr,astr,nstr);
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');      
    fig3 = findobj(0,'Tag','fig3');          
    tpolyplot(TPOLYTOOL_figp,fstr,tstr,astr,zoomstr,xlimstr, ...
               epsilonstr,fig1,fig2);    
    errorplot(fstr,tstr,astr,zoomstr,epsilonstr,fig3);        
    setall(TPOLYTOOL_figp,fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr);


%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for onen button.   
  
  case 'onen'

    [fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr] = getall(TPOLYTOOL_figp);
    nstr = '1';
    tstr = gettpoly(fstr,astr,nstr);
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');      
    fig3 = findobj(0,'Tag','fig3');          
    tpolyplot(TPOLYTOOL_figp,fstr,tstr,astr,zoomstr,xlimstr, ...
               epsilonstr,fig1,fig2);    
    errorplot(fstr,tstr,astr,zoomstr,epsilonstr,fig3);        
    setall(TPOLYTOOL_figp,fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr);


%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for Legend button.   
  
  case 'legend'

    [fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr] = getall(TPOLYTOOL_figp);
    fig1 = findobj(0,'Tag','fig1');
    fig2 = findobj(0,'Tag','fig2');      
    fig3 = findobj(0,'Tag','fig3');          
    tpolyplot(TPOLYTOOL_figp,fstr,tstr,astr,zoomstr,xlimstr, ...
               epsilonstr,fig1,fig2);    
    errorplot(fstr,tstr,astr,zoomstr,epsilonstr,fig3);        
    setall(TPOLYTOOL_figp,fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr);
    
%%%%%%%%%%%%%%%%%%%%%%%%%% Callback for Close button.
  
case 'close'
   delete(findobj(0,'Tag','fig1')); 
   delete(findobj(0,'Tag','fig2')); 
   delete(findobj(0,'Tag','fig3'));    
   delete(findobj(0,'Tag','TPOLYTOOL_figp')); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end % switch statement for callbacks

end     % end of if statement

function [fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr] = getall(tpolytool)
  fstr = get(findobj(tpolytool,'Tag','Sfstr'),'String');
  nstr = get(findobj(tpolytool,'Tag','Snstr'),'String');  
  tstr = get(findobj(tpolytool,'Tag','tstr'),'UserData');
  astr = get(findobj(tpolytool,'Tag','Sastr'),'String');
  zoomstr = get(findobj(tpolytool,'Tag','Szoomstr'),'String');  
  xlimstr = get(findobj(tpolytool,'Tag','Sxlimstr'),'String');
  epsilonstr = get(findobj(tpolytool,'Tag','Sepsilonstr'),'String');
  
function setall(tpolytool,fstr,nstr,tstr,astr,zoomstr,xlimstr,epsilonstr)
  set(findobj(tpolytool,'Tag','Sfstr'),'String',fstr);
  set(findobj(tpolytool,'Tag','Snstr'),'String',nstr);  
  set(findobj(tpolytool,'Tag','tstr'),'UserData',tstr);
  set(findobj(tpolytool,'Tag','Sastr'),'String',astr);
  set(findobj(tpolytool,'Tag','Szoomstr'),'String',zoomstr);
  set(findobj(tpolytool,'Tag','Sxlimstr'),'String',xlimstr);
  set(findobj(tpolytool,'Tag','Sepsilonstr'),'String',epsilonstr);  
  
function tpolyplot(tpolytool,fstr,tstr,astr,zoomstr,xlimstr,epsilonstr,fig1,fig2)
  syms x;
  fsym = sym(fstr);
  tsym = sym(tstr);
  center = str2num(astr);
  zoomarr = str2num(zoomstr);
  zoom_a = zoomarr(1);
  zoom_b = zoomarr(2);
  epsilonval = str2num(epsilonstr);
  fcenter = double(subs(fsym,x,center));
  xlimarr = str2num(xlimstr);
  a = xlimarr(1);
  b = xlimarr(2);
  a2 = zoom_a;
  b2 = zoom_b;
  plotn = 200;
  deltaxplot = (b-a)/plotn;
  xvalplot = a+deltaxplot.*[0:plotn];  
  yvalplotf = double(subs(fsym,x,xvalplot));
  yvalplott = double(subs(tsym,x,xvalplot));  
  maxy = max(yvalplotf);
  miny = min(yvalplotf);
  eps = (maxy-miny)*0.05;
  c = miny-eps;
  d = maxy+eps;
  plotn2 = 200;
  deltaxplot2 = (zoom_b-zoom_a)/plotn2;
  xvalplot2 = a2+deltaxplot2.*[0:plotn2];
  yvalplotf2 = double(subs(fsym,x,xvalplot2));
  yvalplotf2_a = yvalplotf2+epsilonval;
  yvalplotf2_b = yvalplotf2-epsilonval;
  yvalplott2 = double(subs(tsym,x,xvalplot2));
  maxy2 = max(yvalplotf2_a);
  miny2 = min(yvalplotf2_b);
  eps2 = (maxy2-miny2)*0.05;
  c2 = miny2-eps2;
  d2 = maxy2+eps2;
  figure(fig1);
  plot(xvalplot,yvalplotf,'LineWidth',2.0);
  axis([a,b,c,d]);
  hold all;
  plot(xvalplot,yvalplott,'LineWidth',2.0,'color','magenta');
  scatter([center],[fcenter],80,'MarkerEdgeColor','b', ...
          'MarkerFaceColor','c','LineWidth',2.0);

  plot([a2,a2],[c,d],'LineWidth',1.0,'color','r');
  plot([b2,b2],[c,d],'LineWidth',1.0,'color','r');
  
  handle = findobj(tpolytool,'Tag','SLegend');
  value = get(handle,'Value');
  if value==get(handle,'Max')
      legend('\fontsize{18} f(x)','\fontsize{18} T_n(x)','Location','NorthWest');
  end;
  hold off;

  % zoom plot
  figure(fig2);
  plot(xvalplot2,yvalplotf2,'LineWidth',2.0);
  axis([a2,b2,c2,d2]);
  hold all;
  plot(xvalplot2,yvalplott2,'LineWidth',2.0,'color','magenta');
  plot(xvalplot2,yvalplotf2_a,'color',[0,0.9,0.1]);
  plot(xvalplot2,yvalplotf2_b,'color',[0,0.9,0.1]);  
  scatter([center],[fcenter],80,'MarkerEdgeColor','b', ...
          'MarkerFaceColor','c','LineWidth',2.0);
  if value==get(handle,'Max')
      legend('\fontsize{18} f(x)','\fontsize{18} T_n(x)','Location','NorthWest');
  end;
  hold off;

function errorplot(fstr,tstr,astr,zoomstr,epsilonstr,fig3)
  syms x;
  zoomarr = str2num(zoomstr);
  zoom_a = zoomarr(1);
  zoom_b = zoomarr(2);
  gstr = strcat('abs(',fstr,'-(',tstr,'))');
  gsym = sym(gstr);
  epsilonval = str2num(epsilonstr);
  a = zoom_a;
  b = zoom_b;
  plotn = 200;
  deltaxplot = (b-a)/plotn;
  xvalplot = a+deltaxplot.*[0:plotn];
  yvalplot = double(subs(gsym,x,xvalplot));
  figure(fig3);
  plot(xvalplot,yvalplot,'LineWidth',2.0,'color','red');
  axis([a,b,0,epsilonval]);
  title('\fontsize{18} | f(x) - T_n(x) |');
  
function [tstr] = gettpoly(fstr,astr,nstr)
  nval = str2num(nstr);
  curval = 1;
  syms x;
  fsym = sym(fstr);
  center = str2num(astr);
  fcenter = subs(fsym,x,center);
  fpsym = diff(fsym,x);
  fpcenter = subs(fpsym,x,center);
  polysym = fcenter+fpcenter*(x-center);
  nextsym = fpsym;
  while (curval < nval)
      curval = curval + 1;
      nextsym = diff(nextsym,x);
      nextcenter = subs(nextsym,x,center);
      nextstuff = nextcenter/factorial(curval);
      nextterm = nextstuff*(x-center)^curval;
      polysym = polysym + nextterm;
  end;
  tstr = char(polysym);

