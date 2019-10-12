# NavHiddenDemo
导航栏的展示和隐藏跳转
1. 背景

    开发中经常遇到类似于网易云音乐个人中心的,导航栏透明滑动到不透明,跳转等操作
    
    ![效果展示](https://github.com/TsnumiDC/NavHiddenDemo/blob/master/IMG_6285.GIF?raw=true)
    
2. 情况1 没有导航栏,变成有导航栏系统提供了方法

```
    navigationController.setNavigationBarHidden(true, animated: true)
```

3. 情况2 有导航栏,和一些按钮和标题,只不过是隐藏的

首先需要设置以下属性
```
    //隐藏导航栏的背景和线
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    
    //不自动调整contentInset
    if #available(iOS 11.0, *) {
        tableView.contentInsetAdjustmentBehavior = .never
    } else {
        automaticallyAdjustsScrollViewInsets = false
    }
    //从顶部开始布局
    extendedLayoutIncludesOpaqueBars = true
```

提供导航栏隐藏的扩展`UINavigationController+Hidden.swift`
```
    func hideNavigationBarBGView() {
        navigationBar.isTranslucent = true
        navigationBar.barTintColor = .clear
    }
    
    func showNavigationBarBGView() {
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .white
    }
```

根据scrollview的contentOffset进行隐藏和展示

```
    private func updateNavigationBarStyle() {
        let anchor: CGFloat = Constant.navBarShowContentOffectY
        if tableView.contentOffset.y < anchor {
            hideNavigationBarBGView()
        } else {
            showNavigationBarBGView()
        }
    }
```

demo中包含了对ios10以下设备的一些兼容处理
