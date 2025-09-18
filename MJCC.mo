package MJCC
   
package Interface
    partial connector Port
      Modelica.SIunits.Pressure p;
      flow Modelica.SIunits.MassFlowRate mdot;
    end Port;

    connector FluidPort_a
      extends MJCC.Interface.Port;
      annotation(
        Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0}, fillPattern = FillPattern.Solid)}));
    end FluidPort_a;

    connector FluidPort_b
      extends MJCC.Interface.Port;
      annotation(
        Icon(graphics = {Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{100, -100}, {-100, 100}})}));
    end FluidPort_b;
  end Interface;

  package Components
    model FluidSource
      parameter Modelica.SIunits.Pressure P_inf "Pressure at Ambient";
      parameter Modelica.SIunits.Temperature T_inf "Temperature at Ambient";
      
      MJCC.Interface.FluidPort_a node annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      P_inf = node.p;
    annotation(
        Icon(graphics = {Ellipse(extent = {{-100, 100}, {100, -100}})}));
  end FluidSource;
    
    model Pipe
      parameter Modelica.SIunits.Diameter D "Pipe Diameter";
      parameter Modelica.SIunits.Length L "Pipe Length";
      parameter Modelica.SIunits.Density rho "Fluid Density";
      parameter Modelica.SIunits.DynamicViscosity mu "Fluid Viscosity";
      parameter Modelica.SIunits.Velocity V "Fluid Velocity";
      
      Modelica.SIunits.Pressure dP "Pressure Drop";
      
      Real Re "Reynolds Number";
      
      MJCC.Interface.FluidPort_a port_1 annotation (Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      MJCC.Interface.FluidPort_b port_2 annotation (Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      
    equation
      Re = (rho * D * V) / mu;
      port_1.mdot = rho * Modelica.Constants.pi * (D / 2) * (D / 2) * V;
      dP = (64 / Re) * ((8 * rho * L) / Modelica.Constants.pi) * (V^2 / D^5);
      port_2.p = port_1.p - dP;
    annotation(
        Icon(graphics = {Rectangle(extent = {{-100, 40}, {100, -40}})}));
end Pipe;
  end Components;

  model Test
  MJCC.Components.FluidSource fluidSource(P_inf = 300000, T_inf = 293.15)  annotation(
      Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Components.Pipe pipe(D = 0.2, L = 10, V = 0.4, mu = 0.001, rho(displayUnit = "kg/m3") = 998.2)  annotation(
      Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
  connect(fluidSource.node, pipe.port_1) annotation(
      Line(points = {{-60, 0}, {-30, 0}}, color = {191, 0, 0}));
  end Test;
  annotation(
    uses(Modelica(version = "3.2.3")));
end MJCC;
