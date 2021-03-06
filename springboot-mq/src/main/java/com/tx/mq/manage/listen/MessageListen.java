package com.tx.mq.manage.listen;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.amqp.core.AcknowledgeMode;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.listener.SimpleMessageListenerContainer;
import org.springframework.amqp.rabbit.listener.adapter.MessageListenerAdapter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component
public class MessageListen {

    public final Log logger = LogFactory.getLog(this.getClass());

    @Autowired
    private ConnectionFactory connectionFactory;

    /**
     * 在容器中加入消息监听
     *
     * @param queue
     * @param messageHandler
     * @param isAck
     * @throws Exception
     */
    public void addMessageLister(String queue, AbstractMessageHandler messageHandler, boolean isAck) throws Exception {
        SimpleMessageListenerContainer container = new SimpleMessageListenerContainer();
        container.setConnectionFactory(this.connectionFactory);
        container.setQueueNames(queue);
        AcknowledgeMode ack = AcknowledgeMode.NONE;
        if (isAck) {
            ack = AcknowledgeMode.MANUAL;
        }
        messageHandler.setAck(queue, ack);
        container.setAcknowledgeMode(ack);
        MessageListenerAdapter adapter = new MessageListenerAdapter(messageHandler);
        container.setMessageListener(adapter);
        container.start();
        this.logger.info("------ 已成功监听异步消息触发通知队列：" + queue + " ------");
    }
}
