# DR3toLisic

将DanceRail谱面有损转换为1deal-Lisic谱面，不带Tag和LockID。

<sub>Partly Transfer DanceRail Charts to 1deal-Lisic Charts, with no Tags and LockID included.</sub>



### 转换规则(Transferring Rules)

- 原Tap转换为Tap/LTap/RTap
  
  <sub>To start with, Convert Taps(DR) into Tap/LTap/RTap(s).</sub>
  
  先识别位置为0的Note，转换成LTap
  
  <sub>First, Identify Notes on Position 0, and Convert Them to LTaps.</sub>
  
  然后识别位置为13的Note，转换成RTap
  
  <sub>Second, Identify Notes on Position 13, and Convert Them to RTaps.</sub>
  
  最后为其余Tap选择一个合适的位置，转换成Lisic中一般的Tap
  
  <sub>Finally, Identify Remaining Taps, Select a Appropriate Position for Them, and Convert Them to Taps.</sub>

- 其它类型Note转换为Catch/LCatch/RCatch，规则同上。
  
  <sub>For Notes of Other Types, Convert them into Catch/LCatch/RCatch(s), following the rule above.</sub>

### 

### 使用方法(How to Use)

1. 用Godot（4.0 alpha12或更高版本）导入这个工程，运行。
   
   <sub>Import the Project to Godot Editor (4.0 alpha12 or Above), Run this directly on the Project Manager.</sub>

2. 在文本框复制粘贴完整的DanceRail谱面，点击“Convert”按钮，即可得到处理完成的Lisic谱面。
   
   <sub>Paste the Whole DanceRail Chart to the TextEdit Panel and Click the "Convert" Button. Conversion Result will be Displayed on the TextEdit.</sub>



### 更新日志(Update Log)

- 20220809：
  
  扩大Catch接收范围（从ExTap到全体非Tap类型）
  
  换用字典结构以适配重构后的Lisic播放器
  
  <sub>Expanding the Type Ranging for Catches, from ExTap to All Non-Tap Types;</sub>
  
  <sub>Shifting to Dictionary Structure, in order to Adapt the Re-Constructed Lisic Player.</sub>

### 

### LICENSE

**Note that DRMaker is NOT a open-resource software, and DanceRail3Viewer is NOT a software under regular open-resource license.**

**MIT License for DR3toLisic:**

Copyright (c) 2022 1dealGas.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

**Godot Engine Included:**

This game uses Godot Engine, available under the following license:

Copyright (c) 2007-2022 Juan Linietsky, Ariel Manzur. Copyright (c) 2014-2022 Godot Engine contributors.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
