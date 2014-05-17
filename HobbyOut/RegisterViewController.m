//
//  RegisterViewController.m
//  HobbyOut
//
//  Created by Srinivas on 05/04/14.
//  Copyright (c) 2014 smartfrog. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterService.h"
#import "MBProgressHUD.h"
#import "ValidateService.h"

@interface RegisterViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate,RegisterServiceDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nicknameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *dayField;
@property (weak, nonatomic) IBOutlet UITextField *monthField;
@property (weak, nonatomic) IBOutlet UITextField *yearField;
@property (weak, nonatomic) IBOutlet UIButton *maleButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;

@property (weak,nonatomic) IBOutlet UIButton *validateButton;
@property (weak, nonatomic) IBOutlet UIButton *addPictureButton;
@property (strong,nonatomic)UIActionSheet *pickerViewPopup;
@property (strong,nonatomic)UIDatePicker *dtPicker;
@property (weak, nonatomic) IBOutlet UIButton *femaleButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *userNameActivityIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *emailActivityIndicator;


- (IBAction)maleButtonAction:(id)sender;
- (IBAction)femaleButtonAction:(id)sender;
- (IBAction)validateAction:(id)sender;
- (IBAction)backAction:(id)sender;
- (IBAction)addPictureAction:(id)sender;


@property (strong,nonatomic)UIImage *selectedImage;
@property (strong,nonatomic)NSDate *selectedDate;
@property(nonatomic)BOOL isUsernameValid;
@property(nonatomic)BOOL isEmailValid;

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
//    self.selectedImage = [UIImage imageNamed:@"profile-icon.jpeg"];
    [self.navigationController setNavigationBarHidden:YES];
     self.avatarView.transform = CGAffineTransformMakeRotation(-6.3 * M_PI/180);
    
    _emailActivityIndicator.hidden = YES;
    _userNameActivityIndicator.hidden = YES;

}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}


-(void)onKeyboardHide:(id)sender{
 
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
}

-(void)onKeyboardShow:(id)sender{
    if (_passwordField.isFirstResponder || _confirmPasswordField.isFirstResponder) {
        float height =  100;
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-height, self.view.frame.size.width, self.view.frame.size.height)];
    }
}

#pragma mark -
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    int i = buttonIndex;
    switch(i)
    {
        case 0:
        {
            UIImagePickerController * picker = [[UIImagePickerController alloc] init] ;
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:^{}];
        }
            break;
        case 1:
        {
            UIImagePickerController * picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:^{}];
        }
        default:
            // Do Nothing.........
            break;
    }
}


-(void)pickPicture{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"changer la photo de profil"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"prendre une photo", @"choisir dans la bibliothèque", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [actionSheet showInView:self.view];
}

#pragma - mark Selecting Image from Camera and Library
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Picking Image from Camera/ Library
    [picker dismissViewControllerAnimated:YES completion:^{}];
    _selectedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    // Adjusting Image Orientation
    NSData *data = UIImagePNGRepresentation(_selectedImage);
    UIImage *tmp = [UIImage imageWithData:data];
    UIImage *fixed = [UIImage imageWithCGImage:tmp.CGImage
                                         scale:_selectedImage.scale
                                   orientation:self.selectedImage.imageOrientation];
    self.selectedImage = fixed;
    self.avatarView.image = self.selectedImage;
    self.selectedImage = [self scaleImage:self.selectedImage toSize:CGSizeMake(150, 150)];
    // Saving Camera/ Library image to Document Directory
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:
//                                [NSString stringWithFormat:@"savedImage%d.png",1]];
//    NSData *imageData = UIImagePNGRepresentation(self.selectedImage);
//    [imageData writeToFile:savedImagePath atomically:NO];

}

#pragma --mark UITextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField == _dayField || textField == _monthField || textField == _yearField) {
        
        
        [self showDatepicker];
        return NO;
    }
    
//    if (_passwordField == textField || _confirmPasswordField == textField) {
//   
//            [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-100, self.view.frame.size.width, self.view.frame.size.height)];
//        
//    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{

}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (textField == _nicknameField) {
        [self validateUsername];
    }
    
    if (textField == _emailField) {
        [self validateEmail];
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
//    if (_passwordField == textField || _confirmPasswordField == textField) {
//        [self.view setFrame:CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == _passwordField || textField == _confirmPasswordField) {
        return !(textField.text.length > 10);
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma --mark DatePicker Methods
-(void)showDatepicker{
    
    _pickerViewPopup = [[UIActionSheet alloc] init];
    const CGFloat toolbarHeight = 44.0f;
    _dtPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, toolbarHeight, 0, 0)];
    _dtPicker.maximumDate = [NSDate date];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    // if (dateStatus==0) {
    _dtPicker.datePickerMode = UIDatePickerModeDate;
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    _dtPicker.minimumDate = [NSDate date];
    /* }else{
     datePicker.datePickerMode = UIDatePickerModeTime;
     [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
     [dateFormatter setDateFormat:@"HH:mm:ss"];
     
     }*/
    _dtPicker.hidden = NO;
    _dtPicker.date = [NSDate date];
    
    [_dtPicker addTarget:self action:@selector(LabelChange:) forControlEvents:UIControlEventValueChanged];
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, toolbarHeight)];
    pickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerToolbar sizeToFit];
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(btncancelPressed:)];
    [barItems addObject:btnCancel];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    [barItems addObject:doneBtn];
    
    
//    lbl1.text=[NSString stringWithFormat:@"%@",dtPicker.date];
    
    
    
    [pickerToolbar setItems:barItems animated:YES];
    
    [_pickerViewPopup addSubview:pickerToolbar];
    [_pickerViewPopup addSubview:_dtPicker];
    [_pickerViewPopup showInView:self.view.superview];
    [_pickerViewPopup setBounds:CGRectMake(0,0,self.view.frame.size.width, 464)];
    
}


-(void)LabelChange:(id)sender{
    
    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [formatter1 setDateFormat:@"yyyy-MMMM-dd"];
    
    NSString  *dateString= [formatter1 stringFromDate:_dtPicker.date];
    
    NSArray *array = [dateString componentsSeparatedByString:@"-"];
    
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *comps = [gregorian components:NSMonthCalendarUnit | NSDayCalendarUnit | NSDateFormatterLongStyle | NSYearCalendarUnit
//                                           fromDate:_dtPicker.date];
//    NSInteger mm = [comps month];
//    NSInteger dd = [comps day];
//    NSInteger yyy = [comps year];
    
    [_dayField setText:array[2]];
    [_monthField setText:array[1]];
    [_yearField setText:array[0]];
    
}

-(void)btncancelPressed:(id)sender{
    [_pickerViewPopup dismissWithClickedButtonIndex:1 animated:YES];
}

-(void)doneButtonPressed:(id)sender{
    [_pickerViewPopup dismissWithClickedButtonIndex:1 animated:YES];
}

#pragma --mark CheckIfPseudo or email exists
-(void)checkIfUsernameUnique{
   RegisterService *registerService = [[RegisterService alloc] initWithDelegate:self];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            _emailField.text, @"email",
                            _nicknameField.text, @"pseudo",
                            nil];
    
    
    [registerService getWithParameters:params forView:self.view];
}

-(BOOL)validate{
    
    BOOL isValid = YES;
    NSString *message = @"";
    
    if (! (_isUsernameValid  && _isEmailValid)) {
        message = @"Eneter valid username (or) user name already existed";
        isValid = NO;
    }else if(!self.selectedImage){
        isValid = NO;
        message = @"please , select an avatar";
    }else if (_maleButton.tag == 0 && _femaleButton.tag == 0) {
        message = @"Please select gender";
        isValid = NO;
    }else if  (_passwordField.text.length > 25 && _passwordField.text.length < 6) {
        message = @"Password too short";
        isValid = NO;
    }else if(_passwordField.text.length > 25){
        message = @"Password length exceeded";
        isValid = NO;
    }else if  (![_passwordField.text  isEqualToString:_confirmPasswordField.text]) {
        message = @"Passwords mismatch";
        isValid = NO;
    }
    
    if (!isValid) {
        [self showMessage:message];
    }

    return isValid;
}

-(void)showAlert:(NSString*)message{
   UIAlertView *alertView =  [[UIAlertView alloc] initWithTitle:@"Hobbyout" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.cancelButtonIndex == buttonIndex) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)showMessage:(NSString*)message{
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    progressHUD.removeFromSuperViewOnHide = YES;
    [self.view addSubview:progressHUD];
    progressHUD.detailsLabelText =[NSString stringWithFormat:@"%@",message];
    progressHUD.mode = MBProgressHUDModeText;
    [progressHUD show:YES];
    [progressHUD hide:YES afterDelay:3];
}

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImageJPEGRepresentation(image, 1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

-(NSString*)avatar{
    NSString *avatarStr = nil;
    if (self.selectedImage) {
        avatarStr =  [NSString stringWithFormat:@"data:image/jpeg;base64,%@",[self encodeToBase64String:self.selectedImage]];
    }
    return avatarStr;
}

-(NSString*)birthDate{
    
    NSDateFormatter* formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [formatter1 setDateFormat:@"yyyy-MM-dd"];
    
    return [formatter1 stringFromDate:_dtPicker.date];
    
//    NSArray *array = [dateString componentsSeparatedByString:@"-"];
    
}
-(void)createMember{
    
//    _isUsernameValid = NO;
    if ([self validate]) {
        RegisterService *registerService = [[RegisterService alloc] initWithRegisterDelegate:self];
        NSMutableDictionary *requestBodyDict = [NSMutableDictionary dictionary];
        [requestBodyDict setValue:_nicknameField.text forKey:@"pseudo"];
        [requestBodyDict setValue:_emailField.text forKey:@"email"];
        [requestBodyDict setValue:_passwordField.text forKey:@"password"];
        [requestBodyDict setValue:_maleButton.tag == 0 ? @"2" : @"1" forKey:@"gender"];
        [requestBodyDict setValue:[self birthDate] forKey:@"birthDate"];
        [requestBodyDict setValue:[self avatar] forKey:@"avatar"];
        
        [registerService postWithParameters:[requestBodyDict copy] forView:self.view];
    }
}


#pragma --mark Validate Service

-(void)validateEmail{
    _emailActivityIndicator.hidden = NO;
    ValidateService *service = [[ValidateService alloc] initWithDelegate:^(NSDictionary *response) {
        _emailActivityIndicator.hidden = YES;
        if ([response[@"success"] boolValue] == YES) {
            _isUsernameValid = YES;
        }else{
            _isUsernameValid = NO;
            [self showMessage:response[@"message"]];
        }
        
    }];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            _emailField.text, @"email",
                            nil];

    [service getWithParameters:params];
}

-(void)validateUsername{
    
    _userNameActivityIndicator.hidden = NO;
    ValidateService *service = [[ValidateService alloc] initWithDelegate:^(NSDictionary *response) {
        
        _userNameActivityIndicator.hidden = YES;
        if ([response[@"success"] boolValue] == YES) {
            _isEmailValid = YES;
        }else{
            _isEmailValid = NO;
             [self showMessage:response[@"message"]];
        }
    }];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                           
                            _nicknameField.text, @"pseudo",
                            nil];
    [service getWithParameters:params];
    
}

#pragma --mark RegisterService Delegate methods
- (void) registerSucess:(RegisterService*)loginService response:(NSDictionary*)response{
    NSLog(@"registerSucess %@",response);
    if (loginService.tag == 100) {
        if ([response[@"success"] intValue] == 1) {
//            [self showMessage:response[@"message"]];
            [self showAlert:response[@"message"]];
        }
    }else{
        if ([response[@"success"] intValue] == 1) {
            _isUsernameValid = YES;
        }
    }
    
}

- (void) registerFail:(RegisterService*)loginService message:(NSString *)message{
     NSLog(@"registerFail %@ ",message);
     [self showMessage:message];
    }

#pragma --mark IBACTIONS
- (IBAction)maleButtonAction:(id)sender {
    UIButton *btn = sender;
    
    if(btn.tag == 0){
        [btn setImage: [UIImage imageNamed:btn.tag == 0 ? @"icon-homme.png" : @"icon-homme1.png"] forState:UIControlStateNormal];
        btn.tag = 1;
        
        _femaleButton.tag = 0;
        [_femaleButton setImage: [UIImage imageNamed:btn.tag == 0 ? @"icon-femme.png" : @"icon-femme1.png"] forState:UIControlStateNormal];
    }else{
        [btn setImage: [UIImage imageNamed:btn.tag == 0 ? @"icon-homme.png" : @"icon-homme1.png"] forState:UIControlStateNormal];
        btn.tag = 0;
    }
}

- (IBAction)femaleButtonAction:(id)sender {
    UIButton *btn = sender;
    if(btn.tag == 0){
        [btn setImage: [UIImage imageNamed:btn.tag == 0 ? @"icon-femme.png" : @"icon-femme1.png"] forState:UIControlStateNormal];
        btn.tag = 1;
        
        _maleButton.tag = 0;
        [_maleButton setImage: [UIImage imageNamed:btn.tag == 0 ? @"icon-homme.png" : @"icon-homme1.png"] forState:UIControlStateNormal];
    }else{
        [btn setImage: [UIImage imageNamed:btn.tag == 0 ?@"icon-femme.png" : @"icon-femme1.png"] forState:UIControlStateNormal];
        btn.tag = 0;
    }
}


- (IBAction)validateAction:(id)sender {
    [self createMember];
}

- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addPictureAction:(id)sender {
    
    [self pickPicture];
}

- (UIImage*)scaleImage:(UIImage*)image toSize:(CGSize)newSize {
    CGSize scaledSize = newSize;
    float scaleFactor = 1.0;
    if( image.size.width > image.size.height ) {
        scaleFactor = image.size.width / image.size.height;
        scaledSize.width = newSize.width;
        scaledSize.height = newSize.height / scaleFactor;
    }
    else {
        scaleFactor = image.size.height / image.size.width;
        scaledSize.height = newSize.height;
        scaledSize.width = newSize.width / scaleFactor;
    }
    
    UIGraphicsBeginImageContextWithOptions( scaledSize, NO, 0.0 );
    CGRect scaledImageRect = CGRectMake( 0.0, 0.0, scaledSize.width, scaledSize.height );
    [image drawInRect:scaledImageRect];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end
