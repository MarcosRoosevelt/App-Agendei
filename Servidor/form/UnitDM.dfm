object dm: Tdm
  OldCreateOrder = False
  OnCreate = ServerMethodDataModuleCreate
  OnDestroy = ServerMethodDataModuleDestroy
  Encoding = esUtf8
  Height = 574
  Width = 357
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 224
    Top = 40
  end
  object EventsUsuario: TDWServerEvents
    IgnoreInvalidParams = False
    Events = <
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'email'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'senha'
            Encoded = True
          end>
        JsonMode = jmPureJSON
        Name = 'login'
        EventName = 'login'
        OnlyPreDefinedParams = False
        OnReplyEventByType = EventsUsuarioEventsloginReplyEventByType
      end>
    ContextName = 'usuario'
    Left = 48
    Top = 112
  end
end
