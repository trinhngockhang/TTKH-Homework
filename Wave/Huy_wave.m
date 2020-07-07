
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%                                                                                     % 
%                                      Pham Huy                                       %
%                                       ICOM                                          %
%                     HSR University of Applied Sciences, Rapperswil                  %
%                                      04.05.2014                                     %
%                                 All rights reserved.                                %
%                                                                                     %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %




function varargout = Huy_wave(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Huy_wave_OpeningFcn, ...
                   'gui_OutputFcn',  @Huy_wave_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function Huy_wave_OpeningFcn(hObject, ~, handles, varargin)
handles.output = hObject;

    guidata(hObject, handles);
    n=60;
    H=zeros(n,n)-2;
    axes(handles.axes3);
    mesh(H);
    axis([1 n 1 n -2 6]);
    set(handles.axes3,'cameraposition',[4 -2.5 8]);
    set(handles.axes3,'visible','off');
    set(handles.text,'visible','off');
    set(handles.clear,'enable','off');
    set(handles.pause,'visible','off');
    set(handles.energy,'enable','off');
    set(handles.sliderDamp,'value',0.2);
    set(handles.sliderSpeed,'value',12);
    set(handles.Damp,'String','0.2');
    set(handles.Speed,'String','12');
    set(handles.editWidth,'String','15');
    set(handles.editHeight,'String','5');
    set(handles.radiobutton1,'value',1)
    set(handles.Grid,'value',1);
    set(handles.RUN_button,'value',1);
    load data;
    global Ekin Epot wasser rwine Z hello;
    wasser=bwat; rwine=wine; Z=beeth; hello=Hi;
    Ekin=[];
    Epot=[];
    
    
    % Say Hi at the beginning
    axes(handles.axes1);
    run=get(handles.RUN_button,'value');
    H = hello;
    oldH=H;
    newH=H;
    i = 2:n-1;
    j = 2:n-1;
    h=surf(newH);
    surface();
    while run
        run=get(handles.RUN_button,'value');
        if ~run
            break
        end
        newH=Wave(60,i,j,0.05,0.5,1,H,oldH,0,0,0);
                % n,i,j,dt,c,k,H,oldH,fix,cont,connect
        set(h,'zdata',newH);
        pause(0.05);
        oldH=H;
        H=newH;
    end

function varargout = Huy_wave_OutputFcn(~, ~, handles) 
varargout{1} = handles.output;



% If the RUN button is hit:
function RUN_button_Callback(hObject, eventdata, handles)
    run=get(hObject,'Value');
    pause(0.1);
    axes(handles.axes1);
    n=60;
    global globH globOH Ekin Epot;
    if run
        toggle(0,handles);
        set(hObject,'String','Stop');
        set(handles.pause,'visible','on');
        ba=get(handles.bar,'value');
        def=get(handles.default,'value');
        dt=0.05;
        H=globH;
        i = 2:n-1;
        j = 2:n-1;
        if eventdata==0
            oldH=globOH;
        else
        oldH=H;
        Ekin=[];
        Epot=[];
        end
        newH=H;
        h=surf(newH);
        % if the default color mode is selected, use no surface
        % rendering at all ==> improve performance
        if def 
            axis([1 n 1 n -2 8]);
            toggleColor(0,handles); % turn buttons visibility off
            delay=0.04;
        else
            surface();
            set(handles.default,'enable','off');
            delay=0.02;% with surface rendering, which takes more time, so speed everything up a bit
        end
    end        


while run
    run=get(hObject,'Value');
    if ~run;
    globOH=oldH;
    globH=H;
        break
    end

    fix = get(handles.fixbound,'Value');
    cont = get(handles.controller,'Value');
    connect = get(handles.conbound,'Value');
    k = str2double(get(handles.Damp,'String'));
    c = str2double(get(handles.Speed,'String'));
    wat = get(handles.Water,'value');
    
    newH = Wave(n,i,j,dt,c,k,H,oldH,fix,cont,connect);% Wave equation

    alp=0.95;
    alp(wat==1)=0.6;% water transparency    
    if ~ba
        set(h,'Zdata', newH,'facealpha',alp);
    else
       bar3(newH);
       set(handles.axes1, 'xDir', 'reverse',...
           'camerapositionmode','manual','cameraposition',[0.5 0.5 7]);
       axis([1 n 1 n -3 7]);
    end
           
   
%           RENDERING OPTIONS
    uipanel11_SelectionChangeFcn(hObject, eventdata, handles)
    gri=get(handles.Grid,'value');
    if ~gri
        shading(handles.axes1,'interp');
    elseif gri && wat
       shading(handles.axes1,'interp');
    else
        shading(handles.axes1,'faceted');
    end

    oldH=H;
    H=newH;
    pause(delay);
end
    paus=get(handles.pause,'Value');
    if paus
        set(hObject,'enable','off');
    else
       % user click Stop instead of Pause
    set(hObject,'String','RUN');
    set(handles.pause,'visible','off');
    toggle(1,handles);
    toggleColor(1,handles);
    set(handles.default,'enable','on');
    globH=ones(60,60);
    multidrop(handles);
    end
    
    
function toggleColor(val,handles)
    if val
        state='on';
    else
        state='off';
    end
    set(handles.Water,'enable',state);
    set(handles.wine,'enable',state);
    set(handles.Coffee,'enable',state);
    set(handles.merc,'enable',state);
    set(handles.paints,'enable',state);
    set(handles.Lava,'enable',state);
    function toggle(val,handles)
    if val
        state='on';
    else
        state='off';
    end
    set(handles.text,'visible',state);
    set(handles.bar,'enable',state);
    set(handles.Grid,'enable',state);
    set(handles.sliderSpeed,'enable',state);
    set(handles.sliderDamp,'enable',state);
    set(handles.energy,'enable',state);
    set(handles.clear,'enable',state);
    


function sliderDamp_Callback(hObject, ~, handles)
    v = get(hObject,'Value');
    s = num2str(v);
    set(handles.Damp,'String',s);
function sliderDamp_CreateFcn(hObject, ~, ~)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
function Damp_Callback(hObject, ~, handles) % display damping value
    v=get(hObject,'string');
    s=str2double(v);
    set(handles.sliderDamp,'value',s)
function Damp_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function sliderSpeed_Callback(hObject, ~, handles)
v = get(hObject,'Value');
s = num2str(v);
set(handles.Speed,'String',s);
function sliderSpeed_CreateFcn(hObject, ~, ~)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
function Speed_Callback(hObject, ~, handles) % display velocity
    v=get(hObject,'string');
    s=str2double(v);
    set(handles.sliderSpeed,'value',s)
function Speed_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function sliderHeight_Callback(hObject, ~, handles)
    v = get(hObject,'Value');
    s = num2str(v);
    set(handles.editHeight,'String',s);
    multidrop(handles);
function sliderHeight_CreateFcn(hObject, ~, ~)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
function editHeight_Callback(hObject, ~, handles) % display height
    v=get(hObject,'string');
    s=str2double(v);
    set(handles.sliderHeight,'value',s)
function editHeight_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function sliderWidth_Callback(hObject, ~, handles)
    v = get(hObject,'Value');
    s = num2str(v);
    set(handles.editWidth,'String',s);
    multidrop(handles);
function sliderWidth_CreateFcn(hObject, ~, ~)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
function editWidth_Callback(hObject, ~, handles) % display width
    v=get(hObject,'string');
    s=str2double(v);
    set(handles.sliderWidth,'value',s)
function editWidth_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


    
% Boundary Conditions: fixed boundaries; with controller; connected boundaries
function fixbound_Callback(hObject, ~, handles)
    set(handles.controller,'value',0);
    set(handles.conbound,'value',0);
    a=get(hObject,'value');
    if a
        set(handles.textC,'visible','off');
        set(handles.textF,'visible','on');
        set(handles.textL,'visible','off');
    else
        set(handles.textF,'visible','off');
    end
function controller_Callback(hObject, ~, handles)
    set(handles.fixbound,'value',0);
    set(handles.conbound,'value',0);
    a=get(hObject,'value');
    if a
        set(handles.textC,'visible','on');
        set(handles.textF,'visible','off');
        set(handles.textL,'visible','off');
    else
        set(handles.textC,'visible','off');
    end
    dam=str2double(get(handles.Damp,'String'));
    spe=str2double(get(handles.Speed,'String'));
    if dam>0.5 && spe >11.9
        set(handles.Speed,'String','11.9');
    end
function conbound_Callback(hObject, ~, handles)
    set(handles.fixbound,'value',0);
    set(handles.controller,'value',0);
    a=get(hObject,'value');
    if a
        set(handles.textC,'visible','off');
        set(handles.textF,'visible','off');
        set(handles.textL,'visible','on');
    else
        set(handles.textL,'visible','off');
    end



function bar_Callback(~, ~, ~)
    
function Grid_Callback(hObject, ~, ~)
    v=get(hObject,'value');
    if v
        set(hObject,'String','Grid on');
    else
        set(hObject,'String','Grid off');
    end



% click on the figure to select drops position
function figure1_WindowButtonDownFcn(~, ~, handles)
    multidrop(handles);
    
% Shapes Panel
function uipanel9_SelectionChangeFcn(~, ~, handles)
    multidrop(handles);

% Color Panel
function uipanel11_SelectionChangeFcn(hObject, ~, handles)
    a=get(handles.RUN_button,'value');
    newButton=get(hObject,'tag');
    global wasser rwine;
    switch newButton
        case 'default'
            colormap(gca,'default');
        case 'Water'
            colormap(gca,wasser);
        case 'Lava'
            colormap(gca,'autumn');
        case 'wine'
            colormap(gca,rwine);
        case 'Coffee'
            colormap(gca,'copper');
        case 'merc'
            colormap(gca,'bone');
        case 'paints'
            colormap(gca,'hsv');
    end
    if ~a
        multidrop(handles);
    end
        

% radiobutton to activate multiple-drops mode
function multi_Callback(hObject, ~, handles)
    a=get(hObject,'value');
    axes(handles.axes1);
    if ~a
        H=ones(60,60);
        plotDrop(handles,H);
    end
    
function multidrop(handles)
    mult=get(handles.multi,'value');
    paus=get(handles.pause,'visible');
    global globH;
    switch paus
        case 'off'
            if mult==1
                H=globH;
                plotDrop(handles,H);
            else    
                H=ones(60,60);
                plotDrop(handles,H);
            end
        case 'on'
            H=globH; %allow users to add drop on the current plot
            plotDrop(handles,H);
    end
    
    
    
function surface()
    lighting phong;
    material shiny;
    lightangle(-45,30)
    light('Position',[-10 20 10]);
    axis([1 60 1 60 -2 8]);
        
function plotDrop(handles,H)
    a=get(handles.RUN_button,'value');
    global globH;
    if ~a
        wat=get(handles.Water,'value');
        H=add_Drop(handles,H);
        globH=H;
        if wat
            surf(H,'facealpha',0.6);
            shading interp;
        else
            surf(H,'facealpha',0.95);
            shading faceted ;
        end
        surface();
    end
function H=add_Drop(handles,H)
    global Z hello globOH;
    axes(handles.axes1);
    n=60;
    width=get(handles.sliderWidth,'Value');
    r=ceil(width/2);
    height=get(handles.sliderHeight,'Value');
    pos=get(handles.axes3,'currentpoint');
    Dropx=floor(pos(2,2));
    Dropy=floor(pos(2,1));
    max=n-r-1;
    min=r+1;
    Dropx(Dropx>max)=max;
    Dropx(Dropx<min)=min;
    Dropy(Dropy>max)=max;
    Dropy(Dropy<min)=min;
    [x,y] = ndgrid(-1:(2/(width)):1);

    a=get(handles.radiobutton1,'Value');
    b=get(handles.radiobutton2,'Value');
    c=get(handles.radiobutton3,'Value');
    d=get(handles.radiobuttonMat,'Value');
    e=get(handles.radiobutton4,'Value');
    f=get(handles.radiobutton5,'Value');
    g=get(handles.beth,'Value');

    if b      % Type 2:
        [x,y] = ndgrid(-1.5:(2/(width/1.5-1)):1);
        D = height*0.5*(exp(-18*x.^2-0.5*y.^2).*cos(4*x)+...
            exp(-3*((x+0.5).^2+0.5*y.^2)));
    elseif c  % Type 3:
        [x,y] = ndgrid(-2.5:(5/(width)):2.5);
        D = height*1.4*y .* exp(-x.^2 - y.^2);
    elseif d  % Matlab Logo:
        D = height*membrane(1,r);
    elseif e  % Peaks:
        [x,y] = ndgrid(-3:(6/(width)):3);
        D=height/12*peaks(x,y);
    elseif a  % Type 1:
        D = height*exp(-5*(x.^2+y.^2));
    elseif f  % Half Sphere:
        [x,y] = ndgrid(-2.1:(4.2/(width)):2.1);
        D=height/4*real((4-x.^2-y.^2).^0.5);
    elseif g  % Bethoven:
        D=height/5*Z;
        D(1,:)=0;
        D(:,1)=0;
        Dropx=2;
        Dropy=2;
        r=1;
    else         % Hi
        set(handles.Speed,'String','0.54');
        set(handles.sliderSpeed,'value',0.54);
        set(handles.Damp,'String','1');
        set(handles.sliderDamp,'value',1);
        D=hello-1;
        Dropx=r+1;
        Dropy=r+1;
    end

    w = size(D,1);
    i2 = (Dropx-r):w+(Dropx-r)-1;
    j2 = (Dropy-r):w+(Dropy-r)-1;
    H(i2,j2)=1;
    H(i2,j2) = H(i2,j2) + D;
    globOH(i2,j2) = H(i2,j2);
            
            


% Plot Energy Flow.
function energy_Callback(~, ~, ~)
    global Ekin Epot;
    tot=Ekin+Epot;
    x=1:length(Ekin);
    figure;
    plot(x,Ekin(),x,Epot(),x,tot());
    legend('Kinetic energy','Potential energy','Total energy');

% Clear button
function clear_Callback(~, ~, handles)
    global globH globOH;
    axes(handles.axes1);
    globH=ones(60,60);
    globOH=globH;
    surf(globH);
    axis([1 60 1 60 -2 8]);

%  Pause/Resume
function pause_Callback(hObject, ~, handles)
    stat=get(hObject,'value');
    switch stat
        case 0 %Resumed
            set(hObject,'string','Pause');
            set(handles.RUN_button,'enable','on');
            set(handles.energy,'enable','on');
            set(handles.clear,'enable','off');
            set(handles.text,'visible','off');
            set(handles.RUN_button,'value',1);
            RUN_button_Callback(handles.RUN_button,0, handles);
        case 1 %Paused
            set(hObject,'string','Resume');
            set(handles.RUN_button,'value',0);
            set(handles.clear,'enable','on');
            set(handles.energy,'enable','on');
            set(handles.text,'visible','on');
    end
    
    
function figure1_WindowKeyPressFcn(~, ~, ~)
    
function figure1_CloseRequestFcn(~, ~, handles)
    % if animation's running, stop it, else close all.
    a=get(handles.RUN_button,'value');
    if a
        set(handles.RUN_button,'value',0);
        cla;
    else
        delete(handles.figure1);
    end

    
function newH=Wave(n,i,j,dt,c,k,H,oldH,fix,cont,connect)
    global Ekin Epot;
         
    % DAMPED WAVE EQUATION:
    %
    % d^2/dt^2*h + K*(dh/dt) = C^2*(d^2*h/dx^2 + d^2*h/dy^2)
    %
    %   where   h := Height
    %           K := Damping Constant
    %           C := Wave Speed
    %   The right side of the equation is the potential (height of one
    %   element regarding its neighbours).
    %   The wave equation implies that acceleration (d^2*h/dt^2) and 
    %   velocity (dh/dt) of each element are produced through its potential.
    %
    % Finite Difference Procedure:
    %
    %   velocity     := dh/dt      :=   (H(i,j)-oldH(i,j))/dt
    %   acceleration := d^2/dt^2*h :=   ((newH(i,j)-H(i,j))-(H(i,j)-oldH(i,j)))/dt^2
    %                               =   (newH(i,j)-2*H(i,j)+oldH(i,j))/dt^2
    %   similar we have:
    %
    %   potential in x-direction := d^2/dx^2*h := (H(i+1,j)-2*H(i,j)+H(i-1,j))/dx^2
    %   potential in y-direction := d^2/dy^2*h := (H(i,j+1)-2*H(i,j)+H(i,j-1))/dy^2
    %   where dx=dy=1; (spacing between 2 points);
    %   It is possible to include the potential in DIAGONAL direction as well.
    %   Nummerical experiments demomstrate that wave shapes look visually
    %   better when all 8 neighbours are taken into account.
    %   But remember, dx and dy, (spacing between 2 points) in diagonal direction is
    %   sqrt(2) and not 1. Therefor 1/dx^2 resp. 1/dy^2 is equal 0.5
    
    %   Apply these to the wave equation above we have:
    
    potential(i,j)= -c^2*((4*H(i,j)-H(i+1,j)-H(i-1,j)-H(i,j+1)-H(i,j-1))...
        +0.5*(4*H(i,j)-H(i+1,j+1)-H(i+1,j-1)-H(i-1,j+1)-H(i-1,j-1))); %  diagonal direction (opitonal)
    velocity(i,j)=(H(i,j)-oldH(i,j))/dt;
    acceleration(i,j)=-k*velocity(i,j)+potential(i,j); %  := (newH(i,j)-2*H(i,j)+oldH(i,j))/dt^2 as mentioned above
    % therefor, the new height is:
    newH(i,j)=acceleration(i,j)*dt^2-oldH(i,j)+2*H(i,j);
      
    % Please take notice that this equation isn't applied for the elements
    % along the edges and at the corners (Boundary Points / Randpunkte),
    % that's why i and j are from 2 to n-1 instead of 1 to n.
    
    
    
    % BOUNDARY CONDITIONS:
    %
    %   Equations for boundary points.
    %   Keep in mind that elements along the edges have 5 neighbours
    %   instead of 8 and vertices only have 3.
    
    
    
    potential(n,j)=-c^2*((3*H(n,j)-H(n-1,j)-H(n,j+1)-H(n,j-1))...
        +0.5*(2*H(n,j)-H(n-1,j+1)-H(n-1,j-1)));
    potential(i,n)=-c^2*((3*H(i,n)-H(i,n-1)-H(i+1,n)-H(i-1,n))...
        +0.5*(2*H(i,n)-H(i+1,n-1)-H(i-1,n-1)));
    potential(1,j)=-c^2*((3*H(1,j)-H(2,j)-H(1,j+1)-H(1,j-1))...
        +0.5*(2*H(1,j)-H(2,j+1)-H(2,j-1)));
    potential(i,1)=-c^2*((3*H(i,1)-H(i,2)-H(i+1,1)-H(i-1,1))...
        +0.5*(2*H(i,1)-H(i+1,2)-H(i-1,2)));
    velocity(n,j)=(H(n,j)-oldH(n,j))/dt;
    velocity(i,n)=(H(i,n)-oldH(i,n))/dt;
    velocity(1,j)=(H(1,j)-oldH(1,j))/dt;
    velocity(i,1)=(H(i,1)-oldH(i,1))/dt;
    
                % 4 corners:
    potential(1,1)=-c^2*((2*H(1,1)-H(2,1)-H(1,2))...
        +0.5*(H(1,1)-H(2,2)));
    potential(1,n)=-c^2*((2*H(1,n)-H(1,n-1)-H(2,n))...
        +0.5*(H(1,n)-H(2,n-1)));
    potential(n,1)=-c^2*((2*H(n,1)-H(n,2)-H(n-1,1))...
        +0.5*(H(n,1)-H(n-1,2)));
    potential(n,n)=-c^2*((2*H(n,n)-H(n-1,n)-H(n,n-1))...
        +0.5*(H(n,n)-H(n-1,n-1)));
    velocity(1,1)=(H(1,1)-oldH(1,1))/dt;
    velocity(1,n)=(H(1,n)-oldH(1,n))/dt;
    velocity(n,1)=(H(n,1)-oldH(n,1))/dt;
    velocity(n,n)=(H(n,n)-oldH(n,n))/dt;



%                       DEFAULT MODUS     
if(~fix && ~cont && ~connect)
    
    acceleration(n,j)=-k*velocity(n,j) +potential(n,j);
    newH(n,j)=acceleration(n,j)*dt^2-oldH(n,j)+2*H(n,j);
    
    acceleration(i,n)=-k*velocity(i,n) +potential(i,n);
    newH(i,n)=acceleration(i,n)*dt^2-oldH(i,n)+2*H(i,n);
    
    acceleration(1,j)=-k*velocity(1,j) +potential(1,j);
    newH(1,j)=acceleration(1,j)*dt^2-oldH(1,j)+2*H(1,j);
    
    acceleration(i,1)=-k*velocity(i,1) +potential(i,1);
    newH(i,1)=acceleration(i,1)*dt^2-oldH(i,1)+2*H(i,1);
    
    
                % 4 corners:
    acceleration(1,1)=-k*velocity(1,1) +potential(1,1);
    newH(1,1)=acceleration(1,1)*dt^2-oldH(1,1)+2*H(1,1);
    
    acceleration(1,n)=-k*velocity(1,n) +potential(1,n);
    newH(1,n)=acceleration(1,n)*dt^2-oldH(1,n)+2*H(1,n);
    
    acceleration(n,1)=-k*velocity(n,1) +potential(n,1);
    newH(n,1)=acceleration(n,1)*dt^2-oldH(n,1)+2*H(n,1);
    
    acceleration(n,n)=-k*velocity(n,n) +potential(n,n);
    newH(n,n)=acceleration(n,n)*dt^2-oldH(n,n)+2*H(n,n);   
    
    
%                STANDSTILL CONTROLLER MODUS
%                Eliminate the wave and bring elements to their steady state.
elseif cont

    H(1,j+1)= 0.5*(oldH(1,j+1)+oldH(2,j+1));
    newH(1,j+1)= H(1,j+1)+0.9*(H(2,j+1)-oldH(2,j+1));
    H(i+1,1)= 0.5*(oldH(i+1,1)+oldH(i+1,2));
    newH(i+1,1)= H(i+1,1)+0.9*(H(i+1,2)-oldH(i+1,2));

    H(1,1)= 0.5*(H(1,1)+H(2,2));
    newH(1,1)= H(1,1)+(H(2,2)-oldH(2,2))/3;
    newH(1,2)= newH(1,1);
    newH(2,1)= newH(1,1);
    Corner_n1=0.5*(H(n,1)+H(n-1,2));
    Corner_1n=0.5*(H(1,n)+H(2,n-1));
    Corner_nn= 0.5*(H(n,n)+H(n-1,n-1));

    H(i+1,n)= 0.5*(oldH(i+1,n)+oldH(i+1,n-1));
    newH(i+1,n)= H(i+1,n)+0.9*(H(i+1,n-1)-oldH(i+1,n-1));
    H(n,j+1)= 0.5*(oldH(n,j+1)+oldH(n-1,j+1));
    newH(n,j+1)= H(n,j+1)+0.9*(H(n-1,j+1)-oldH(n-1,j+1));

    newH(n,n)= Corner_nn;
    newH(n,n-1)= Corner_nn;
    newH(n-1,n)= Corner_nn;
    newH(1,n-1)=Corner_1n;
    newH(1,n)=Corner_1n;
    newH(2,n)=Corner_1n;
    newH(n,1)=Corner_n1;
    newH(n-1,1)=Corner_n1;
    newH(n,2)=Corner_n1;

    acceleration(n,j)=-k*velocity(n,j) +potential(n,j);
    acceleration(i,n)=-k*velocity(i,n) +potential(i,n);
    acceleration(1,j)=-k*velocity(1,j) +potential(1,j);
    acceleration(i,1)=-k*velocity(i,1) +potential(i,1);
                % 4 corners:
    acceleration(1,1)=-k*velocity(1,1) +potential(1,1);
    acceleration(1,n)=-k*velocity(1,n) +potential(1,n);
    acceleration(n,1)=-k*velocity(n,1) +potential(n,1);
    acceleration(n,n)=-k*velocity(n,n) +potential(n,n);


%                FIXED BOUNDARIES MODUS
%                All boundary points have a constant value of 1.
elseif  fix                   
    newH(1,:)=1;
    newH(n,:)=1;
    newH(:,1)=1;
    newH(:,n)=1;

    velocity(1,:)=0;
    velocity(n,:)=0;
    velocity(:,1)=0;
    velocity(:,n)=0;

    acceleration(n,j)=potential(n,j);
    acceleration(i,n)=potential(i,n);
    acceleration(1,j)=potential(1,j);
    acceleration(i,1)=potential(i,1);
        % 4 corners:
    acceleration(1,1)=potential(1,1);
    acceleration(1,n)=potential(1,n);
    acceleration(n,1)=potential(n,1);
    acceleration(n,n)=potential(n,n);


%               CONNECTED BOUNDARIES MODUS
%               Water flows across the edges and comes back from the opposite side
else                                    
    potential(1,j)=-c^2*((4*H(1,j)-H(2,j)-H(n,j)-H(1,j+1)-H(1,j-1))...
    +0.5*(4*H(1,j)-H(2,j+1)-H(2,j-1)-H(n,j+1)-H(n,j-1)));
    acceleration(1,j)=-k*velocity(1,j) +potential(1,j);
    newH(1,j)=acceleration(1,j)*dt^2-oldH(1,j)+2*H(1,j);

    potential(n,j)=-c^2*((4*H(n,j)-H(1,j)-H(n-1,j)-H(n,j+1)-H(n,j-1))...
    +0.5*(4*H(n,j)-H(1,j+1)-H(1,j-1)-H(n-1,j+1)-H(n-1,j-1))); 
    acceleration(n,j)=-k*velocity(n,j) +potential(n,j);
    newH(n,j)=acceleration(n,j)*dt^2-oldH(n,j)+2*H(n,j);

    potential(i,1)=-c^2*((4*H(i,1)-H(i,n)-H(i-1,1)-H(i+1,1)-H(i,2))...
    +0.5*(4*H(i,1)-H(i+1,2)-H(i+1,n)-H(i-1,2)-H(i-1,n)));
    acceleration(i,1)=-k*velocity(i,1) +potential(i,1);
    newH(i,1)=acceleration(i,1)*dt^2-oldH(i,1)+2*H(i,1);

    potential(i,n)=-c^2*((4*H(i,n)-H(i+1,n)-H(i-1,n)-H(i,1)-H(i,n-1))...
    +0.5*(4*H(i,n)-H(i+1,1)-H(i+1,n-1)-H(i-1,1)-H(i-1,n-1))); 
    acceleration(i,n)=-k*velocity(i,n) +potential(i,n);
    newH(i,n)=acceleration(i,n)*dt^2-oldH(i,n)+2*H(i,n);
    
            % 4 Corners
    potential(n,n)=-c^2*((4*H(n,n)-H(1,n)-H(n,1)-H(n,n-1)-H(n-1,n))...
    +0.5*(4*H(n,n)-H(1,n-1)-H(1,1)-H(n-1,n-1)-H(n-1,1))); 
    acceleration(n,n)=-k*velocity(n,n) +potential(n,n);
    newH(n,n)=acceleration(n,n)*dt^2-oldH(n,n)+2*H(n,n);    

    potential(n,1)=-c^2*((4*H(n,1)-H(1,1)-H(n,n)-H(n,2)-H(n-1,1))...
    +0.5*(4*H(n,1)-H(1,2)-H(1,n)-H(n-1,n)-H(n-1,2))); 
    acceleration(n,1)=-k*velocity(n,1) +potential(n,1);
    newH(n,1)=acceleration(n,1)*dt^2-oldH(n,1)+2*H(n,1);

    potential(1,1)=-c^2*((4*H(1,1)-H(1,n)-H(1,2)-H(n,1)-H(2,1))...
    +0.5*(4*H(1,1)-H(2,2)-H(n,2)-H(n,n)-H(2,n))); 
    acceleration(1,1)=-k*velocity(1,1) +potential(1,1);
    newH(1,1)=acceleration(1,1)*dt^2-oldH(1,1)+2*H(1,1);

    potential(1,n)=-c^2*((4*H(1,n)-H(1,1)-H(n,n)-H(2,n)-H(1,n-1))...
    +0.5*(4*H(1,n)-H(n,1)-H(2,1)-H(2,n-1)-H(n,n-1))); 
    acceleration(1,n)=-k*velocity(1,n) +potential(1,n);
    newH(1,n)=acceleration(1,n)*dt^2-oldH(1,n)+2*H(1,n);


end

    kin=velocity.^2;
    pot=-acceleration.*oldH;
    Ekin=[Ekin sum(kin(:))];
    Epot=[Epot sum(pot(:))];
