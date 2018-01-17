

//
//  ViewController.swift
//  CaptureImage
//
//  Created by Dynamsoft on 8/22/17.
//  Copyright © 2017 Dynamsoft. All rights reserved.
//

import UIKit
class ViewController: UIViewController,DcsUIVideoViewDelegate,DcsUIImageEditorViewDelegate,DcsUIImageGalleryViewDelegate{
    
    var openVideoViewButton:UIButton!
    var dcsView:DcsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /////////////add UINavigationBar  ////////////////////////////////
        var navigatorBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64));
        let titleItem = UINavigationItem(title: "CaptureImage");
        navigatorBar.pushItem(titleItem, animated: true);
        self.view.addSubview(navigatorBar);
        
        /////////////add DcsView  ////////////////////////////////
        dcsView = DcsView.self.init(frame:CGRect.init(x: 0, y:navigatorBar.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height-navigatorBar.frame.size.height));
        dcsView.currentView = DVE_IMAGEGALLERYVIEW;
        dcsView.imageGalleryView.delegate = self;
        
        //////////////video view setting////////////////////////////////
        //Set the videoview mode to image
        dcsView.videoView.mode      = DME_IMAGE;
        dcsView.videoView.nextViewAfterCancel  = DVE_IMAGEGALLERYVIEW;
        dcsView.videoView.nextViewAfterCapture = DVE_EDITORVIEW;
        dcsView.videoView.delegate = self;
        ////////////DocumentEditView setting////////////////////
        dcsView.imageEditorView.nextViewAfterOK     = DVE_IMAGEGALLERYVIEW;
        dcsView.imageEditorView.nextViewAfterCancel = DVE_VIDEOVIEW;
        dcsView.imageEditorView.delegate = self;
        self.view.addSubview(dcsView);
        
        openVideoViewButton = CreateOpenVideoButton(imageFrame:CGRect.init(x:(self.view.frame.size.width-84)/2, y:self.view.frame.size.height-175, width:84, height:84));
        openVideoViewButton.addTarget(self, action:#selector(onClick), for:UIControlEvents.touchUpInside);
        dcsView.imageGalleryView.addSubview(openVideoViewButton);
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func CreateOpenVideoButton(imageFrame:CGRect)->UIButton{
        var button:UIButton!
        let btnNormalImg    = UIImage.init(named: "icon_camera");
        let btnSelectedImg  = UIImage.init(named: "icon_camera-selected");
        
        button          = UIButton.init(type:UIButtonType.custom);
        button.frame    = imageFrame;//CGRect.init(x:0, y:0, width:(btnNormalImg?.size.width)!, height:(btnNormalImg?.size.height)!)    ;
        button.setBackgroundImage(btnNormalImg, for: UIControlState.normal);
        button.setBackgroundImage(btnSelectedImg, for: UIControlState.selected);
        return button;
    }
    
    @objc func onClick(){
        dcsView.currentView = DVE_VIDEOVIEW
    }
    ///////////////////////////////////////////////////////
    //UIVideoView delegate implement
    func onCancelTapped(_ sender: Any!) {
        if sender is DcsUIVideoView{
            print( "video view cancel tap invoked");
        }
        if sender is DcsUIImageEditorView{
            print( "imageEditorView cancel tap invoked");
        }
    }
    func onPostCapture(_ sender: Any!) {
        print( "PostCapture invoked");
    }
    func onCaptureTapped(_ sender: Any!) {
        print( "CaptureTapped invoked");    }
    func onPreCapture(_ sender: Any!) -> Bool {
        print( "PreCapture invoked");
        return true;
    }
    func onCaptureFailure(_ sender: Any!, exception: DcsException!) {
        print( "CaptureFailure invoked");
    }
    
    func onDocumentDetected(_ sender: Any!, document: DcsDocument!) {
        
    }
    //////////////////////////////////////////////////////
    //DcsUIImageEditorView Delegate implement
    func  onOkTapped(_ sender: Any!, exception: DcsException!) {
        print("OkTap invoked");
    }
    
    //////////////////////////////////////////////////////
    //DcsUIImageGalleryViewDelegate implement
    func onSingleTap(_ sender: Any!, index: Int) {
        print("SingleTap invoked");
    }
    
    func onLongPress(_ sender: Any!, index: Int) {
        print( "LongPress invoked");
    }
    
    func onSelectChanged(_ sender:Any!, selectedIndices indices: [Any]!) {
        print( "SelectChanged invoked");
    }
    
}

