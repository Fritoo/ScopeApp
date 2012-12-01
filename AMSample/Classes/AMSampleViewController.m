//
//  AMSampleViewController.m
//  AMSample
//
//  Created by Susumu.KOBAYASHI on 2010/07/01.
//  Copyright 2010 Scalar Co.,LTD All rights reserved.
//

#import "AMSampleViewController.h"


@implementation AMSampleViewController

- (void)finishExport:(UIImage *)image
didFinishSavingWithError:(NSError *)error
		 contextInfo:(void *)contextInfo
{
	NSLog(@" my_savePicture: diden!!");
}

- (void)captureDone:(UIImage *)image
{
	NSLog(@" captureDone!");
	UIImageWriteToSavedPhotosAlbum( image, self,
	   @selector(finishExport:didFinishSavingWithError:contextInfo:), nil );
}
	
- (void)freezeDone:(bool)isFreeze
{
	if( isFreeze )	NSLog(@" freezeDone! -- FREEZE");
	else 	NSLog(@" freezeDone! -- Live");
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

	[super viewDidLoad];
	capField = [[UILabel alloc] initWithFrame:CGRectMake(110,190,85,20)];
	frzField = [[UILabel alloc] initWithFrame:CGRectMake(10,80,70,20)];
	indField = [[UIActivityIndicatorView alloc] 
				initWithFrame:CGRectMake(150,200,20,20)];
	capField.text=@"CAPTURE";
	frzField.text=@"Freeze";

	airmicro = nil;

    
	UIButton *capBtn = [UIButton  buttonWithType:UIButtonTypeRoundedRect];
	[capBtn setTitle:@"capture" forState:UIControlStateNormal];
	[capBtn sizeToFit];
	capBtn.frame = CGRectMake(20,370,100,30);
	[capBtn addTarget:self action:@selector(savePicture) forControlEvents:UIControlEventTouchDown];
	[self.view addSubview:capBtn];
	
	NSArray *items=[NSArray arrayWithObjects:@"Live",@"Freeze",nil];
	UISegmentedControl *segBtn=[[UISegmentedControl alloc] initWithItems:items];
	segBtn.selectedSegmentIndex = 0;
	segBtn.frame = CGRectMake(150,370,150,30);
	[segBtn addTarget:self action:@selector(LiveOfFreeze:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:segBtn];

	UIButton *amBtn = [UIButton  buttonWithType:UIButtonTypeRoundedRect];
	[amBtn setTitle:@"STRAT" forState:UIControlStateNormal];
	[amBtn sizeToFit];
	amBtn.frame = CGRectMake(110,30,100,30);
	[amBtn addTarget:self action:@selector(amControl:) forControlEvents:UIControlEventTouchDown];
	[self.view addSubview:amBtn];
	
	UIApplication * app=[UIApplication sharedApplication];
	app.idleTimerDisabled=YES;
}


//Toggle feed and button
- (void)amControl:(id)sender {
    
    printf("PressedButton__\n\n");
	UIButton *amBtn=sender;
	if( airmicro==nil ){
		[amBtn setTitle:@"STOP" forState:UIControlStateNormal];
		NSLog(@" amControl - create!");

        //Actual feed
		airmicro = [[AMImageView alloc] init:self.view rect:CGRectMake(0,80,320,240)];
		[airmicro setDelegate:self]; 
		[airmicro setBtnControl:TRUE];
		[airmicro setFrzLabel:frzField];
		[airmicro setCapLabel:capField];
		[airmicro setIndicator:indField];
        
//		[airmicro setWaitImage:IMG1 next:IMG2];
		[airmicro setSavePictureFolderFlag:FALSE];
		[airmicro setCapViewTime:1.5];
		[self.view addSubview:frzField];
		[self.view addSubview:capField];
		[self.view addSubview:indField];	
	}else{
		[amBtn setTitle:@"STRAT" forState:UIControlStateNormal];
		NSLog(@" amControl - release!");
		[airmicro stopCapture];
		airmicro.hidden=YES;
		[airmicro release];
		airmicro=nil;
	}
}

- (void)savePicture {
	[airmicro savePicture];
}

- (void)LiveOfFreeze:(id)sender {
	UISegmentedControl *seg=sender;
	bool flg=TRUE;
	if(seg.selectedSegmentIndex==0) flg=FALSE;
	[airmicro setFreeze:flg];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[airmicro release];
    [super dealloc];
}

@end
