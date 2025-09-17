package MJCC
  package Interface
    connector Port
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
        Icon(graphics = {Rectangle(lineColor = {0, 0, 255},fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{100, -100}, {-100, 100}})}));
    end FluidPort_b;
  end Interface;
end MJCC;
