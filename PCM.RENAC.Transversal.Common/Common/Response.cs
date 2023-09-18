using FluentValidation.Results;

namespace PCM.RENAC.Transversal.Common
{
    public class Response<T> : Response
    {
        public T Data { get; set; }
    }

    public class Response
    {
        public bool IsSuccess { get; set; }
        public bool Error { get; set; }
        public string? Message { get; set; }
        public Dictionary<string, object>? ResultList { get; set; }
        public IEnumerable<ValidationFailure>? Errors { get; set; }
    }
}
