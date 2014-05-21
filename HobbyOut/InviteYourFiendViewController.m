//
//  InviteYourFiendViewController.m
//  HobbyOut
//
//  Created by Srinivas on 17/05/14.
//  Copyright (c) 2014 smartfrog. All rights reserved.
//

#import "InviteYourFiendViewController.h"
#import "AppStyle.h"
#import <AddressBook/AddressBook.h>
#import "InviteFriendCell.h"

@interface InviteYourFiendViewController (){
    NSMutableArray *_contactList;
}
@property (weak, nonatomic) IBOutlet UIView *signInFBView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *confirmAccessView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *fbButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmAccessButton;

@property (weak, nonatomic) IBOutlet UIButton *contactsButton;
@property (weak, nonatomic) IBOutlet UIButton *fbSigninButton;
@property (weak, nonatomic) IBOutlet UIImageView *segmentBgImageView;


- (IBAction)facebookSegmentAction:(id)sender;
- (IBAction)contactSegmentAction:(id)sender;
- (IBAction)fbSigninAction:(id)sender;
- (IBAction)contactAccessAction:(id)sender;



@end

@implementation InviteYourFiendViewController

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
    [self initView];
}

-(void)initView{
    
    self.title = @"INVITE TES AMIS";
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 29)];
    [leftButton setImage:[UIImage imageNamed:@"bt-back.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backAction)
         forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.view.backgroundColor = [AppStyle backgroundColor];
    
    self.fbButton.titleLabel.textColor = [UIColor darkGrayColor];
    self.fbButton.tag = 1;
    self.contactsButton.titleLabel.textColor = [UIColor lightGrayColor];
    self.fbButton.tag = 0;
    self.segmentBgImageView.image = [UIImage imageNamed:@"carnetadresse-filtre-on-off.png"];
    self.contactsButton.titleLabel.numberOfLines = 2;
    self.contactsButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.contentView.hidden = YES;
    self.confirmAccessView.hidden = YES;
    self.signInFBView.hidden = NO;
    [_tableView setBackgroundColor:[UIColor clearColor]];
    
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma --mark FetchContacts

-(void)fetchContacts {
    
    _signInFBView.hidden = YES;
    _confirmAccessView.hidden = YES;
    _contentView.hidden = NO;
    
    ABAddressBookRef addressBook = ABAddressBookCreate();
    _contactList = [[NSMutableArray alloc] init];
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
    
    for (int i=0;i < nPeople;i++) {
        NSMutableDictionary *dOfPerson=[NSMutableDictionary dictionary];
        
        ABRecordRef ref = CFArrayGetValueAtIndex(allPeople,i);
        
        //For username and surname
        ABMultiValueRef phones =(__bridge ABMultiValueRef)((__bridge NSString*)ABRecordCopyValue(ref, kABPersonPhoneProperty));
        
        CFStringRef firstName, lastName;
        firstName = ABRecordCopyValue(ref, kABPersonFirstNameProperty);
        lastName  = ABRecordCopyValue(ref, kABPersonLastNameProperty);
        [dOfPerson setObject:[NSString stringWithFormat:@"%@ %@", firstName, lastName] forKey:@"name"];
        
        //For Email ids
        ABMutableMultiValueRef eMail  = ABRecordCopyValue(ref, kABPersonEmailProperty);
        if(ABMultiValueGetCount(eMail) > 0) {
            [dOfPerson setObject:(__bridge NSString *)ABMultiValueCopyValueAtIndex(eMail, 0) forKey:@"email"];
            
        }
        
        //For Phone number
        NSString* mobileLabel;
        
        for(CFIndex i = 0; i < ABMultiValueGetCount(phones); i++) {
            mobileLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(phones, i);
            if([mobileLabel isEqualToString:(NSString *)kABPersonPhoneMobileLabel])
            {
                [dOfPerson setObject:(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, i) forKey:@"Phone"];
            }
            else if ([mobileLabel isEqualToString:(NSString*)kABPersonPhoneIPhoneLabel])
            {
                [dOfPerson setObject:(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, i) forKey:@"Phone"];
                break ;
            }
            
        }
        [_contactList addObject:dOfPerson];
        
    }
    
    NSLog(@"Contacts = %@",_contactList);
    [_tableView reloadData];
    
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contactList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"OptionCell";
    InviteFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"InviteFriendCell" owner:nil options:nil];
        cell = array[0];
        cell.backgroundColor = [UIColor clearColor];
    }
	NSDictionary *info= _contactList[indexPath.row];
	cell.nameLabel.text = info[@"name"];
    [AppStyle headerText:cell.nameLabel];
	[cell refreshView];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    InviteFriendCell *cell = (InviteFriendCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell check];
}


#pragma --mark UIButton Actions

- (IBAction)facebookSegmentAction:(id)sender {
    
    self.fbButton.titleLabel.textColor = [UIColor darkGrayColor];
    self.fbButton.tag = 1;
    self.contactsButton.titleLabel.textColor = [UIColor lightGrayColor];
    self.fbButton.tag = 0;
    self.segmentBgImageView.image = [UIImage imageNamed:@"carnetadresse-filtre-on-off.png"];
    self.contactsButton.titleLabel.numberOfLines = 2;
    self.tableView.hidden = YES;
    self.confirmAccessView.hidden = YES;
    self.signInFBView.hidden = NO;
}

- (IBAction)contactSegmentAction:(id)sender {
    
    self.fbButton.titleLabel.textColor = [UIColor lightGrayColor];
    self.fbButton.tag = 1;
    self.contactsButton.titleLabel.textColor = [UIColor darkGrayColor];
    self.fbButton.tag = 0;
    self.segmentBgImageView.image = [UIImage imageNamed:@"carnetadresse-filtre-off-on.png"];
    self.contactsButton.titleLabel.numberOfLines = 2;
    self.tableView.hidden = YES;
    self.confirmAccessView.hidden = NO;
    self.signInFBView.hidden = YES;
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        //2
        _confirmAccessView.hidden = YES;
        _tableView.hidden = NO;
        NSLog(@"Authorized");
        [self fetchContacts];
    }
}


- (IBAction)fbSigninAction:(id)sender {
}

- (IBAction)contactAccessAction:(id)sender {
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
        ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted){
        //1
        NSLog(@"Denied");
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        //2
        NSLog(@"Authorized");
        [self fetchContacts];
    } else{ //ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined
        //3
        NSLog(@"Not determined");
        ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!granted){
                    //4
                    UIAlertView *cantAddContactAlert = [[UIAlertView alloc] initWithTitle: @"Cannot Add Contact" message: @"You must give the app permission to add the contact first." delegate:nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
                    [cantAddContactAlert show];
                    return;
                }
                //5
                [self fetchContacts];
            });
        });

    }
}
@end
