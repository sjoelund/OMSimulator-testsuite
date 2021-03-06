-- status: correct
-- teardown_command: rm DualMassOscillator_me.log DualMassOscillator_me.mat

oms2_setLogFile("DualMassOscillator_me.log")
oms2_setTempDirectory("./DualMassOscillator_me_tmp")
oms2_newFMIModel("DualMassOscillator")

-- instantiate FMUs
oms2_addFMU("DualMassOscillator", "../FMUs/DualMassOscillator.System1_me.fmu", "System1")
oms2_addFMU("DualMassOscillator", "../FMUs/DualMassOscillator.System2_me.fmu", "System2")

-- add connections
oms2_addConnection("DualMassOscillator", "System1:F", "System2:F")
oms2_addConnection("DualMassOscillator", "System1:s", "System2:s")
oms2_addConnection("DualMassOscillator", "System1:v", "System2:v")
oms2_addConnection("DualMassOscillator", "System1:a", "System2:a")

oms2_setResultFile("DualMassOscillator", "DualMassOscillator_me.mat")

oms2_setStopTime("DualMassOscillator", 0.1)
oms2_setCommunicationInterval("DualMassOscillator", 1e-5)

oms2_initialize("DualMassOscillator")
oms2_simulate("DualMassOscillator")

tcur = oms2_getCurrentTime("DualMassOscillator")
vars = {"DualMassOscillator.System1:s", "DualMassOscillator.System2:s"}
for _,var in ipairs(vars) do
  print(var .. " at " .. tcur .. ": " .. oms2_getReal(var))
end

oms2_reset("DualMassOscillator")

oms2_setStopTime("DualMassOscillator", 0.2)
oms2_initialize("DualMassOscillator")
oms2_simulate("DualMassOscillator")

tcur = oms2_getCurrentTime("DualMassOscillator")
for _,var in ipairs(vars) do
  print(var .. " at " .. tcur .. ": " .. oms2_getReal(var))
end
oms2_terminate("DualMassOscillator")

oms2_unloadModel("DualMassOscillator")

-- Result:
-- DualMassOscillator.System1:s at 0.1: -0.607142765476
-- DualMassOscillator.System2:s at 0.1: -0.607142765476
-- DualMassOscillator.System1:s at 0.2: -0.075580314382809
-- DualMassOscillator.System2:s at 0.2: -0.075580314382809
-- info:    2 warnings
-- info:    0 errors
-- info:    Logging information has been saved to "DualMassOscillator_me.log"
-- endResult
