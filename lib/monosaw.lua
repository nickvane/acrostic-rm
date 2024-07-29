local Formatters=require 'formatters'
local Monosaw={}

function Monosaw:new (o)
  o=o or {} -- create object if user does not provide one
  setmetatable(o,self)
  self.__index=self
  return o
end

function Monosaw:init()
  self.message=""
  self.message_level=0
  self.lpffreq=20000
  params:add_group("phantom",7)
  local filter_freq=controlspec.new(20,20000,'exp',0,20000,'Hz')
  params:add{type="control",id="monosaw_amp",name="amp",
    controlspec=controlspec.new(0.0,1,'lin',0.01,0.0,"amp",0.01/1),action=function(x)
      engine.amp(x)
    end
  }
  params:add{type="control",id="monosaw_detuning",name="detuning",
    controlspec=controlspec.new(0,100,'lin',0.25,2.5,"%",0.25/100),action=function(x)
      engine.detuning(x/100)
    end
  }
  params:add{type="control",id="monosaw_lpfmin",name="min lpf",
    controlspec=filter_freq,formatter=Formatters.format_freq,action=function(x)
      engine.lpfmin(x)
    end
  }
  params:add{type="control",id="monosaw_lpfadj",name="lpf adj",
    controlspec=filter_freq,formatter=Formatters.format_freq,action=function(x)
      engine.lpfadj(x)
    end
  }
  params:add{type="control",id="monosaw_lpflfo",name="lpf lfo",
    controlspec=controlspec.new(0.1,10,'exp',0.1,0.1,"Hz",0.1/10),action=function(x)
      engine.lpflfo(x)
    end
  }
  params:add{type="control",id="monosaw_delay",name="delay",
    controlspec=controlspec.new(0.01,0.25,'lin',0.01,0.25,"s",0.01/0.25),action=function(x)
      engine.delay(x/0.25)
    end
  }
  params:add{type="control",id="monosaw_feedback",name="feedback",
    controlspec=controlspec.new(0.01,1,'lin',0.01,0.0,"",0.01/1),action=function(x)
      engine.feedback(x)
    end
  }
  params:set("monosaw_detuning",2.4)
  params:set("monosaw_lpfmin",121)
  params:set("monosaw_lpfadj",2190)
  params:set("monosaw_lpflfo",0.28)
  params:set("monosaw_amp",0.5)
  params:set("monosaw_delay",1)
  params:set("monosaw_feedback",0)
  self.lpffreq={0,0}
  osc.event=function(path,args,from)
    if path=="lpf" then
      self.lpffreq[tonumber(args[1])]=args[2]
    end
  end
end

function Monosaw:key(k,z)
  if global_shift then
    if k==1 then
    elseif k==2 then
    elseif k==3 then
    end
    do return end
  end
  if k==1 then
  elseif k==2 then
  elseif k==3 then
  end
end

function Monosaw:msg(s)
  self.message=s
  self.message_level=15
end

function Monosaw:enc(k,d)
  if global_shift then
    if k==1 then
    elseif k==2 then
      params:delta("monosaw_amp",d)
      self:msg("amp: "..params:get("monosaw_amp"))
    elseif k==3 then
      params:delta("monosaw_feedback",d)
      self:msg("fdbk: "..params:get("monosaw_feedback"))
    end
    do return end
  end
  if k==1 then
    params:delta("monosaw_lpflfo",d)
    self:msg("lpf lfo: "..(math.floor(params:get("monosaw_lpflfo")*100)/100)..' hz')
  elseif k==2 then
    params:delta("monosaw_lpfmin",d)
    self:msg("lpf min: "..math.floor(params:get("monosaw_lpfmin"))..' hz')
  elseif k==3 then
    params:delta("monosaw_lpfadj",d)
    self:msg("lpf max: "..math.floor(params:get("monosaw_lpfmin")+params:get("monosaw_lpfadj")).." hz")
  end
end

-- code generously provided @2994898
-- original code:  https://github.com/monome-community/nc01-drone/blob/master/three-eyes.lua
function Monosaw:draw()  
  if self.message_level>0 and self.message~="" then
    self.message_level=self.message_level-1
    screen.aa(0)
    screen.move(96,8)
    screen.level(self.message_level)
    screen.text_center(self.message)
  end
end

return Monosaw
