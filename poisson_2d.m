Nx=100;Ny=100;Lx=2;Ly=2;clear;clc
%Inputs

%2DGrid
x=linspace(0,Lx,Nx); y=linspace(0,Ly,Ny);
dx=x(2)-x(1);dy=y(2)-y(1);
%Initialize matrices
N=Nx*Ny; % # of unkown
A=zeros(N,N);
b=zeros(N,1);
%Generate Interior points via for loop
for i=2:Nx-1   % Loop over x direction, skipping 1st and last grid points
    for j=2:Ny-1   % Loop over y direction, skipping 1st and last grid points
        n=i+(j-1)*Nx; % convert ij grid point to the nth grid point
        A(n,n) = -4;  %Main diagonal
        A(n,n-1) =1;% off diagonal to the left
        A(n,n+1) =1;% off diagonal to the right
        A(n,n-Nx)=1;% Far off diagonal to the left
        A(n,n+Nx)=1;% far off diagonal to the right
        b(n,1)=-2*pi^2*sin(pi*x(i)).*sin(pi*y(j));% Source term
    end 
end 
%% Boundary conditions
%Left BC 
i=1;
for j=1:Ny
    n=i+(j-1)*Nx; %nth row of this ij
    A(n,n)=1; % main diagonal
    b(n,1)=0; % BC at y_j
end
%Right BC 
i=Nx;
for j=1:Ny
    n=i+(j-1)*Nx; %nth row of this ij
    A(n,n)=1; % main diagonal
    b(n,1)=0; % BC at y_j
end
%Bottom BC 
j=1;
for i=1:Nx
    n=i+(j-1)*Nx; %nth row of this ij
    A(n,n)=1; % main diagonal
    b(n,1)=0; % BC at x_i
end
%Top BC 
j=Ny;
for i=1:Nx
    n=i+(j-1)*Nx; %nth row of this ij
    A(n,n)=1; % main diagonal
    b(n,1)=0; % BC at x_i
end
%Obtain the solution vector 
u= (1/dx^2)*A\b;
%Convert vector solution to a 2D array
for i = 1:Nx
    for j=1:Ny
    n=i+(j-1)*Nx;  % nth row of tis ij
    phi(i,j) = u(n) ;
    end
end     
%% Plot numerical solution
figure(1)
surf(x,y,phi'); xlabel('x'); ylabel('y'); title('Numerical Solution');
%% Plot true solution
figure(2)
x = linspace(0,2,100); y = x';
z= sin(pi*x).*sin(pi*y);
surf(x,y,z);xlabel('x'); ylabel('y'); title('Analytical Solution');

%% Obtain max error over the mesh 
max_true= max(z, [], 'all'); max_numerical= max(abs(u)); 
Maximum_Error=abs(max_numerical-max_true)
