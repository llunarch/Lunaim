local P=game:GetService("Players").LocalPlayer
local G=P:WaitForChild("PlayerGui")
local E=getgenv()
E.AUT_AUTO_OK_ID=(E.AUT_AUTO_OK_ID or 0)+100
E.AUT_PROMPT_OK_ID=(E.AUT_PROMPT_OK_ID or 0)+100
E.AUT_HIDE_INV_PROMPT_ID=(E.AUT_HIDE_INV_PROMPT_ID or 0)+1
local I=E.AUT_HIDE_INV_PROMPT_ID
for _,n in ipairs({"AUT_AUTO_OK_CONN","AUT_INV_POPUP_CONN","AUT_INV_BLOCKER_CONN","AUT_PROMPT_OK_CONN","AUT_PROMPT_TITLE_CONN","AUT_HIDE_INV_VISIBLE_CONN","AUT_HIDE_INV_TEXT_CONN"}) do local c=E[n] if c then pcall(function()c:Disconnect()end) E[n]=nil end end
local U=G:WaitForChild("UI")
local Q=U:WaitForChild("Prompt")
local F=Q:WaitForChild("Frame")
local T=F:WaitForChild("Label")
local B=F:WaitForChild("SingleButton")
local busy=false
local function close()
 if E.AUT_HIDE_INV_PROMPT_ID~=I or busy or T.Text~="Inventory Disabled" then return end
 busy=true
 Q.Visible=false
 if type(firesignal)=="function" then
  pcall(function()firesignal(B.MouseButton1Click)end)
  pcall(function()firesignal(B.Activated)end)
 else
  pcall(function()B:Activate()end)
 end
 task.wait(0.02)
 if T.Text=="Inventory Disabled" then Q.Visible=false end
 busy=false
end
E.AUT_HIDE_INV_VISIBLE_CONN=Q:GetPropertyChangedSignal("Visible"):Connect(function()if E.AUT_HIDE_INV_PROMPT_ID==I and Q.Visible and T.Text=="Inventory Disabled" then close() end end)
E.AUT_HIDE_INV_TEXT_CONN=T:GetPropertyChangedSignal("Text"):Connect(function()if E.AUT_HIDE_INV_PROMPT_ID==I and T.Text=="Inventory Disabled" then close() end end)
close()