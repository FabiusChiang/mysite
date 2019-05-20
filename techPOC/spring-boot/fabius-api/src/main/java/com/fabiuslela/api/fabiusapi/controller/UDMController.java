package com.fabiuslela.api.fabiusapi.controller;

import java.util.Map;

import com.fp.aws.lambda.restClient.OfficeApiRestClient;
import org.springframework.web.bind.annotation.*;

// import javax.servlet.http.HttpServletRequest;
// import java.util.List;

/**
 * Created by Fabius Jiang
 * <p>
 * UDM controller provides basic information of the service to serve monitor requests.
 */
@RestController
@RequestMapping("/udm")
public class UDMController {

    // @Autowired
    // PublishService publishService;

    /**
     * Publishes an advisor proposal.  If a different document type is to be introduced,
     * a separate Controller and endpoint should be added along with an applicable ReportType
     * in pub-common
     *
     * @return
     */
    // @CrossOrigin
    // @ResponseBody
    // @RequestMapping(path = "/proposal/publish_bak", method = RequestMethod.POST)
    // public EndpointResponse publishProposal(@RequestBody ApiProposalRequest proposalRequest, HttpServletRequest request) {
    //     RequestContext context = createRequestContext(request);
    //     String submissionId = publishService.generateSubmissionId();
    //     List<SubmissionResult> results = publishService.queueRequests(submissionId, proposalRequest, context);
    //     return ControllerResponseUtility.convertToStatusResponse(submissionId, results);
    // }

    @GetMapping("/id/{id}/dataset/{dset}")
    public String getId(@PathVariable Map<String,String> pathParams) {
        
        OfficeApiRestClient restClient = new OfficeApiRestClient();
        return restClient.testFuncInRestClient(pathParams.get("id") + ":" + pathParams.get("dset"));
    }


    @GetMapping("/getFunc")
    public String findOne() {
        OfficeApiRestClient restClient = new OfficeApiRestClient();
        return restClient.testFuncInRestClient("fake ID");
    }

}
