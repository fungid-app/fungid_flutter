# fungid_api.api.ObservationsApi

## Load the API package
```dart
import 'package:fungid_api/api.dart';
```

All URIs are relative to *https://api.fungid.app*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getAllObservationsObservationsGet**](ObservationsApi.md#getallobservationsobservationsget) | **GET** /observations/ | Get All Observations
[**getImageByIdObservationsImagesImageIdGet**](ObservationsApi.md#getimagebyidobservationsimagesimageidget) | **GET** /observations/images/{image_id} | Get Image By Id
[**getObservationImagesByObservationIdObservationsObservationIdImagesGet**](ObservationsApi.md#getobservationimagesbyobservationidobservationsobservationidimagesget) | **GET** /observations/{observation_id}/images | Get Observation Images By Observation Id
[**getObservationImagesObservationsImagesGet**](ObservationsApi.md#getobservationimagesobservationsimagesget) | **GET** /observations/images | Get Observation Images
[**getObservationsByIdObservationsIdGet**](ObservationsApi.md#getobservationsbyidobservationsidget) | **GET** /observations/{id} | Get Observations By Id
[**getObservationsBySpeciesObservationsBySpeciesSpeciesGet**](ObservationsApi.md#getobservationsbyspeciesobservationsbyspeciesspeciesget) | **GET** /observations/by_species/{species} | Get Observations By Species


# **getAllObservationsObservationsGet**
> PageGbifObservation getAllObservationsObservationsGet(page, size)

Get All Observations

### Example
```dart
import 'package:fungid_api/api.dart';

final api = FungidApi().getObservationsApi();
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.getAllObservationsObservationsGet(page, size);
    print(response);
} catch on DioError (e) {
    print('Exception when calling ObservationsApi->getAllObservationsObservationsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | [optional] [default to 1]
 **size** | **int**|  | [optional] [default to 50]

### Return type

[**PageGbifObservation**](PageGbifObservation.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getImageByIdObservationsImagesImageIdGet**
> GbifObservationImage getImageByIdObservationsImagesImageIdGet(imageId)

Get Image By Id

### Example
```dart
import 'package:fungid_api/api.dart';

final api = FungidApi().getObservationsApi();
final int imageId = 56; // int | 

try {
    final response = api.getImageByIdObservationsImagesImageIdGet(imageId);
    print(response);
} catch on DioError (e) {
    print('Exception when calling ObservationsApi->getImageByIdObservationsImagesImageIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **imageId** | **int**|  | 

### Return type

[**GbifObservationImage**](GbifObservationImage.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getObservationImagesByObservationIdObservationsObservationIdImagesGet**
> PageGbifObservationImage getObservationImagesByObservationIdObservationsObservationIdImagesGet(observationId, page, size)

Get Observation Images By Observation Id

### Example
```dart
import 'package:fungid_api/api.dart';

final api = FungidApi().getObservationsApi();
final int observationId = 56; // int | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.getObservationImagesByObservationIdObservationsObservationIdImagesGet(observationId, page, size);
    print(response);
} catch on DioError (e) {
    print('Exception when calling ObservationsApi->getObservationImagesByObservationIdObservationsObservationIdImagesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **observationId** | **int**|  | 
 **page** | **int**|  | [optional] [default to 1]
 **size** | **int**|  | [optional] [default to 50]

### Return type

[**PageGbifObservationImage**](PageGbifObservationImage.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getObservationImagesObservationsImagesGet**
> PageGbifObservationImage getObservationImagesObservationsImagesGet(page, size)

Get Observation Images

### Example
```dart
import 'package:fungid_api/api.dart';

final api = FungidApi().getObservationsApi();
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.getObservationImagesObservationsImagesGet(page, size);
    print(response);
} catch on DioError (e) {
    print('Exception when calling ObservationsApi->getObservationImagesObservationsImagesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | [optional] [default to 1]
 **size** | **int**|  | [optional] [default to 50]

### Return type

[**PageGbifObservationImage**](PageGbifObservationImage.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getObservationsByIdObservationsIdGet**
> GbifObservation getObservationsByIdObservationsIdGet(id)

Get Observations By Id

### Example
```dart
import 'package:fungid_api/api.dart';

final api = FungidApi().getObservationsApi();
final int id = 56; // int | 

try {
    final response = api.getObservationsByIdObservationsIdGet(id);
    print(response);
} catch on DioError (e) {
    print('Exception when calling ObservationsApi->getObservationsByIdObservationsIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**GbifObservation**](GbifObservation.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getObservationsBySpeciesObservationsBySpeciesSpeciesGet**
> PageGbifObservation getObservationsBySpeciesObservationsBySpeciesSpeciesGet(species, page, size)

Get Observations By Species

### Example
```dart
import 'package:fungid_api/api.dart';

final api = FungidApi().getObservationsApi();
final String species = species_example; // String | 
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.getObservationsBySpeciesObservationsBySpeciesSpeciesGet(species, page, size);
    print(response);
} catch on DioError (e) {
    print('Exception when calling ObservationsApi->getObservationsBySpeciesObservationsBySpeciesSpeciesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **species** | **String**|  | 
 **page** | **int**|  | [optional] [default to 1]
 **size** | **int**|  | [optional] [default to 50]

### Return type

[**PageGbifObservation**](PageGbifObservation.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

