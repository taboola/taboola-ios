//
//  TBChangeInfoViewController.m
//  TaboolaDemoApp
//

#import "TBChangeInfoViewController.h"

@interface TBChangeInfoViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;
@property (weak, nonatomic) IBOutlet UITextField *publisherTextField;
@property (weak, nonatomic) IBOutlet UITextField *modeTextField;
@property (weak, nonatomic) IBOutlet UITextField *placementTextField;
@property (weak, nonatomic) IBOutlet UITextField *pageURLTextField;
@property (weak, nonatomic) IBOutlet UITextField *pageTypeTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) NSArray *arrayOfKeys;

@end

@implementation TBChangeInfoViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.saveButton setEnabled:NO];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    tapGesture.cancelsTouchesInView = YES;
    [self.view addGestureRecognizer:tapGesture];
    
    self.arrayOfKeys = @[@"publisher", @"mode", @"placement", @"pageURL", @"pageType"];
    
    self.publisherTextField.text = @"thumbnails-sdk3";
    self.modeTextField.text = @"betterbytheminute-app";
    self.placementTextField.text = @"article";
    self.pageURLTextField.text = @"http://www.example.com";
    self.pageTypeTextField.text = @"Mobile second";
    
    [self actionChangeTextField:nil];
}

#pragma mark - Private Method

- (void)dismissKeyboard {
    [self.view endEditing:true];
}

#pragma mark - Actions

- (IBAction)actionDismissViewController:(UIButton *)sender {
    
    if (self.callback) {
        NSMutableDictionary *widgetAttributes = [NSMutableDictionary new];
        NSInteger index = 0;
        for (NSString* key in self.arrayOfKeys) {
            [widgetAttributes setValue:[self.textFields[index] text] forKey:key];
            index++;
        }
        self.callback(widgetAttributes);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)actionChangeTextField:(UITextField *)sender {
    
    BOOL isEnabled = true;
    
    for (UITextField* textField in self.textFields) {
        if ([textField.text length] == 0) {
            isEnabled = false;
            break;
        }
    }

    [self.saveButton setEnabled:isEnabled];
}

#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    NSInteger currentIndex = [self.textFields indexOfObject:textField];
    if (currentIndex + 1 < [self.textFields count]) {
        [self.textFields[currentIndex + 1] becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return NO;
}

@end
