# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
use_frameworks!

def shared_pods
    pod 'PromiseKit', '~> 6.2'
    pod 'Alamofire', '~> 4.7'
    pod 'PromiseKit/Alamofire', '~> 6.2'
    pod 'ReachabilitySwift', '~> 4.1'
    pod 'Player', '~> 0.8.4'
    pod 'PopupDialog', '~> 0.7'
    pod 'NotificationBannerSwift', '~> 1.6'
    pod 'HTTPStatusCodes', '~> 3.2'
    pod 'Cache', '~> 4.2'
    pod 'GradientProgressBar', '~> 1.2'
end

target 'workday-solution' do
    shared_pods
end

target 'workday-solutionTests' do
    shared_pods
end

target 'workday-solutionUITests' do
    shared_pods
end
